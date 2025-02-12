import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:cannon_physics/cannon_physics.dart' as cannon;
import 'package:maxiyatzy/models/ModelProvider.dart';
import 'package:three_js/three_js.dart' as three;

final AmplifyLogger _logger = AmplifyLogger('MaxiYatzyApp');

extension on cannon.Quaternion {
  three.Quaternion toQuaternion() {
    return three.Quaternion(x, y, z, w);
  }
}

extension on cannon.Vec3 {
  three.Vector3 toVector3() {
    return three.Vector3(x, y, z);
  }
}

extension on Vector3 {
  cannon.Vec3 toVec3() {
    return cannon.Vec3(x ?? 0, y ?? 0, z ?? 0);
  }
}

extension on DieQuaternion {
  cannon.Quaternion toQuaternion() {
    return cannon.Quaternion(x ?? 0, y ?? 0, z ?? 0, w ?? 0);
  }
}

class GameScreen extends StatefulWidget {
  final Game game;
  final User user;

  @override
  State<GameScreen> createState() => _GameScreenState();

  const GameScreen({super.key, required this.game, required this.user});
}

class _GameScreenState extends State<GameScreen>
    with SingleTickerProviderStateMixin {
  StreamSubscription<GraphQLResponse<User>>? onCreateSubscription;
  StreamSubscription<GraphQLResponse<User>>? onDeleteSubscription;

  List<User> _users = [];

  late cannon.World world;

  late List<three.Material> materials;
  late three.ThreeJS threeJs;
  late three.OrbitControls controls;
  late List<Map<String, dynamic>> models;
  late List<Map<String, dynamic>> units;

  int numLoadedModels = 0;
  List<DieObject> dice = [];

  static const double mass = 20;
  static const double diceSize = 1;
  static const double shininess = 50; // default 30
  static const double reflectivity = 1; // default 1
  static const double specular = 0x226012;
  static const double tableSize = 30;
  static const double dropHeight = 10;
  static const double maxVel = 13;

  late double lastCallTime;
  bool split = true;

  var faces = [
    {'value': 1, 'vector': three.Vector3(1, 0, 0), 'dot': 0},
    {'value': 2, 'vector': three.Vector3(-1, 0, 0), 'dot': 0},
    {'value': 3, 'vector': three.Vector3(0, 1, 0), 'dot': 0},
    {'value': 4, 'vector': three.Vector3(0, -1, 0), 'dot': 0},
    {'value': 5, 'vector': three.Vector3(0, 0, 1), 'dot': 0},
    {'value': 6, 'vector': three.Vector3(0, 0, -1), 'dot': 0}
  ];

  bool disposed = false;
  bool verbose = true;
  late math.Random rand;

  three.LoadingManager manager = three.LoadingManager();

  @override
  void initState() {
    manager.onStart = (url, itemsLoaded, itemsTotal) {
      _logger.info(
          'Started loading file: $url.\nLoaded $itemsLoaded of $itemsTotal files.');
    };

    manager.onLoad = () {
      _logger.info('Loading complete!');
    };

    manager.onProgress = (url, itemsLoaded, itemsTotal) {
      _logger.info(
          'Loading file: $url.\nLoaded $itemsLoaded of $itemsTotal files.');
    };

    manager.onError = (url) {
      _logger.error('There was an error loading $url');
    };

    threeJs = three.ThreeJS(
      onSetupComplete: () {
        _refreshUsers();
        setState(() async {
          await _joinGame();
        });
      },
      setup: setup,
    );

    super.initState();
  }

  @override
  void dispose() {
    _leaveGame(widget.game);
    threeJs.dispose();
    three.loading.clear();
    controls.dispose();
    super.dispose();
  }

  Future<void> setup() async {
    models = [
      {"name": "lowpolydice"},
    ];
    // Here we define instances of the models that we want to place in the scene, their position, scale and the animations
    // that must be played.
    units = [
      {
        "modelName": "lowpolydice", // Will use the 3D model from file
        "meshName": "Dice_", // Name of the main mesh to animate
        "scale": 1.0, // Scaling of the unit. 1.0 means: use original size
      },
    ];

    threeJs.scene = three.Scene();

    setupCamera();
    setupControls();
    setupLights();
    setupGround(100);
    initCannonPhysics();
    loadModels();

    threeJs.addAnimationEvent((dt) {
      controls.update();
      world.step(1 / 60, dt, 3);
      for (DieObject die in dice) {
        die.update(dt);
      }
    });

    threeJs.renderer?.autoClear = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Game: ${widget.game.name}"), actions: [
        OutlinedButton(
          onPressed: () {
            if (context.mounted) {
              Navigator.of(context).pop();
            }
          },
          child: const Text("Back to lobby"),
        )
      ]),
      body: Stack(
        children: [
          threeJs.build(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Text("Throw dice"),
        onPressed: () async {
          ThrowResponse response = await throwDice(1);
          instantiateUnits(response);
        },
      ),
    );
  }

  setupGround(double tableSize) async {
    try {
      // Create the ground
      final texture = await three.TextureLoader().fromAsset('assets/wood.jpg');
      // Create the heightfield geometry
      var geometry =
          three.PlaneGeometry(tableSize, tableSize).rotateX(-math.pi / 2);

      Map<String, dynamic> parameters = {"color": 0x9B5523};
      if (texture != null) {
        parameters["map"] = texture;
        texture.needsUpdate = true;
      }
      // Create the material
      var material = three.MeshPhongMaterial.fromMap(parameters);
      var groundMesh = three.Mesh(geometry, material);
      groundMesh.receiveShadow = true;
      groundMesh.castShadow = true;
      threeJs.scene.add(groundMesh);

      var shape = cannon.Plane();
      var body = cannon.Body(mass: 1);
      body.addShape(shape);
      world.addBody(body);
    } on Exception catch (e) {
      _logger.error('setupGround', e);
    }
  }

  setupCamera() {
    threeJs.camera =
        three.PerspectiveCamera(45, threeJs.width / threeJs.height, 0.1, 1000);
    // Adjust camera position and orientation
    threeJs.camera.position.setValues(10, 30, 80);
    threeJs.camera.lookAt(three.Vector3(2, 0, 4));
  }

  setupControls() {
    controls = three.OrbitControls(threeJs.camera, threeJs.globalKey);
    controls.enableDamping = true;
    controls.dampingFactor = 0.25;
  }

  setupLights() {
    var ambientLight = three.AmbientLight(0x606060);
    threeJs.scene.add(ambientLight);

    var directionalLight =
        three.DirectionalLight(0xffffff, 1); // White light with full intensity
    directionalLight.position.setValues(5, 30, 5);
    directionalLight.castShadow = true; // Enable shadows for the light
    var shadowCamera = three.OrthographicCamera(-40, 40, 40, -40, 0.5, 50);
    directionalLight.shadow = three.LightShadow(shadowCamera);
    directionalLight.shadow!.mapSize = three.Vector2(1024, 1024);
    threeJs.scene.add(directionalLight);

    var pointLight = three.PointLight(0xffffff, 0.5);
    pointLight.position.setValues(0, 0, 0);
    threeJs.scene.add(pointLight);

    var sunLight = three.PointLight(0xffffff, 0.7);
    sunLight.position.setValues(0, 0, 100);
    threeJs.scene.add(sunLight);
  }

  Future<void> _joinGame() async {
    try {
      _logger.info('Joining game');
      final updatedUser = widget.user.copyWith(game: widget.game);
      final request = ModelMutations.update(updatedUser);
      await Amplify.API.mutate(request: request).response;
    } on ApiException catch (e) {
      _logger.error('JoinGame failed', e);
    } on CancellationException catch (e) {
      _logger.warn('JoinGame cancelled', e);
      _leaveGame(widget.game);
    }
  }

  Future<void> _startGame() async {
    try {
      _logger.info('Starting game');
      final game = widget.game;
      final updatedGame = game.copyWith(state: GameState.ongoing);
      final request = ModelMutations.update(updatedGame);
      await Amplify.API.mutate(request: request).response;
    } on ApiException catch (e) {
      _logger.error('StartGame failed', e);
    }
  }

  Future<void> _leaveGame(Game game) async {
    try {
      _logger.info('Leaving game');
      final updatedUser = widget.user.copyWith(game: null);
      final request = ModelMutations.update(updatedUser);
      final response = await Amplify.API.mutate(request: request).response;
      _logger.info('Response: $response');

      // game should be deleted by server after the user leaves
    } on ApiException catch (e) {
      _logger.error('LeaveGame failed', e);
    }
  }

  Future<ThrowResponse> throwDice(int numberOfDice) async {
    _logger.info('Throwing $numberOfDice dice');
    const graphQLDocument = '''
      query ThrowDice(\$numberOfDice: Int!) {
        throwDice(numberOfDice: \$numberOfDice) {
          gravity { x y z },
          groundPosition { x y z },
          dice {
            position { x y z },
            quaternion { x y z w },
            velocity { x y z },
            angularVelocity { x y z }
          }
        }
      }
    ''';

    try {
      final request = GraphQLRequest<String>(
        document: graphQLDocument,
        variables: {"numberOfDice": numberOfDice},
      );
      final response = await Amplify.API.query(request: request).response;
      if (response.hasErrors) {
        throw ApiOperationException('Throwing dice failed: ${response.errors}');
      }

      Map<String, dynamic> jsonMap =
          json.decode(response.data!) as Map<String, dynamic>;
      final responseJson = ThrowResponse.fromJson(jsonMap);
      return responseJson;
    } on Exception catch (e) {
      _logger.error('Error while throwing', e);
      rethrow;
    }
  }

  void subscribe() {
    final onCreateRequest = ModelSubscriptions.onCreate(User.classType);
    final onDeleteRequest = ModelSubscriptions.onDelete(User.classType);

    final Stream<GraphQLResponse<User>> create = Amplify.API.subscribe(
      onCreateRequest,
    );
    final Stream<GraphQLResponse<User>> delete = Amplify.API.subscribe(
      onDeleteRequest,
    );

    onCreateSubscription = create.listen(
      (event) {
        if (event.data != null) {
          setState(() {
            _users.add(event.data!);
          });
        }
      },
      onError: (Object e) => _logger.error('Error in subscription stream', e),
    );
    onDeleteSubscription = delete.listen(
      (event) {
        if (event.data != null) {
          setState(() {
            _users.remove(event.data!);
          });
        }
      },
      onError: (Object e) => _logger.error('Error in subscription stream', e),
    );
  }

  Future<void> _refreshUsers() async {
    try {
      _logger.info('Fetching user for game: ${widget.game.id}');
      final request = ModelQueries.list(User.classType,
          where: User.GAME.eq(widget.game.id));
      final response = await Amplify.API.query(request: request).response;
      if (response.hasErrors) {
        _logger.error('Refresh users errors: ${response.errors}');
        return;
      }
      _logger.debug('Refresh users', response.data);
      final users = response.data?.items;
      setState(() {
        _users = users?.whereType<User>().toList() ?? [];
      });
    } on ApiException catch (e) {
      _logger.error('Query failed', e);
    }
  }

  cannon.Trimesh createTrimesh(three.BufferGeometry geometry) {
    var vertices =
        (geometry.attributes['position'] as three.BufferAttribute).array;

    var verticesList =
        List<double>.from(vertices.toList().map((n) => n.toDouble()));

    var indices = geometry.index?.array;
    var indicesList = List<int>.from(indices!.toList().map((n) => n.toInt()));

    return cannon.Trimesh(verticesList, indicesList);
  }

  void makeMeshVisible(three.Mesh mesh, bool visible) {
    mesh.traverse((child) {
      if (child is three.Mesh) {
        child.visible = visible;
      }
    });
  }

  void instantiateUnits(ThrowResponse response) {
    _logger.debug('Instantiating throw response', response);
    int numSuccess = 0;

    var g = response.throwDice.gravity;
    world.gravity = cannon.Vec3(g.x!, g.y!, g.z!);
    if (response.throwDice.dice.isEmpty) {
      return;
    }

    List<Die> diceResponse = response.throwDice.dice;

    if (dice.isNotEmpty) {
      for (int i = 0; i < 6; i++) {
        DieObject die = dice.firstWhere(
          (element) => element.name == i,
          orElse: () => DieObject(),
        );

        if (i < diceResponse.length) {
          final Die diceParam = diceResponse[i];
          cannon.Vec3 p = diceParam.position!.toVec3();
          cannon.Quaternion r = diceParam.quaternion!.toQuaternion();
          cannon.Vec3 v = diceParam.velocity!.toVec3();
          cannon.Vec3 a = diceParam.angularVelocity!.toVec3();

          makeMeshVisible(die.mesh!, true);
          die.updatePosition(p);
          die.updateQuaternion(r);
          die.updateVelocity(v);
          die.updateAngularVelocity(a);
          die.body?.wakeUp();
        } else {
          makeMeshVisible(die.mesh!, false);
        }

        numSuccess++;
      }
    } else {
      final u = units[0];
      var model = getModelByName(u["modelName"])!;
      three.Object3D? clonedScene = model["scene"];
      if (clonedScene == null && clonedScene is three.Object3D) {
        _logger.warn('Model not found');
        return;
      }
      final three.Mesh mesh =
          clonedScene?.getObjectByName(u["meshName"]) as three.Mesh;
      if (mesh.geometry == null) {
        _logger.warn('Mesh not found');
      }
      mesh.castShadow = true;
      mesh.receiveShadow = true;

      cannon.Trimesh shape =
          createTrimesh(mesh.geometry as three.BufferGeometry);
      _logger.debug('indices', shape.indices.length.toString());
      _logger.debug('vertices', shape.vertices.length.toString());

      for (int i = 0; i < diceResponse.length; i++) {
        final Die diceParam = diceResponse[i];
        cannon.Vec3 p = diceParam.position!.toVec3();
        cannon.Quaternion r = diceParam.quaternion!.toQuaternion();
        cannon.Vec3 v = diceParam.velocity!.toVec3();
        cannon.Vec3 a = diceParam.angularVelocity!.toVec3();

        _logger.debug('Creating die $numSuccess');
        var body = cannon.Body(mass: 1);
        body.addShape(shape);
        world.addBody(body);
        threeJs.scene.add(clonedScene as three.Object3D);

        numSuccess++;

        DieObject die = DieObject(mesh: mesh, body: body, name: numSuccess);
        dice.add(die);
        die.updatePosition(p);
        die.updateQuaternion(r);
        die.updateVelocity(v);
        die.updateAngularVelocity(a);
        die.body?.allowSleep = true;
      }
    }

    _logger.info("Successfully instantiated $numSuccess units ");
  }

  void loadModels() {
    three.Cache.enabled = true;
    final loader = three.GLTFLoader(manager: manager);

    for (int i = 0; i < models.length; ++i) {
      dynamic m = models[i];
      loadGltfModel(loader, m, (scene) {
        ++numLoadedModels;
      });
    }
  }

  Map<String, dynamic>? getModelByName(String name) {
    _logger.debug("Looking for model $name");
    for (int i = 0; i < models.length; ++i) {
      if (models[i]["name"] == name) {
        _logger.info("Model $name found");
        return models[i];
      }
    }

    _logger.error("Model $name not found");
    return null;
  }

  Future<dynamic> loadGltfModel(loader, model, onLoaded) async {
    final modelName = "${model["name"]}.glb";
    final gltf = await loader.fromAsset(modelName);
    final scene = gltf!.scene;

    model["scene"] = scene;

    onLoaded(scene);

    return model;
  }

  //----------------------------------
  //  cannon PHYSICS
  //----------------------------------

  void initCannonPhysics() {
    world = cannon.World(gravity: cannon.Vec3(0, -9.82, 0));
    world.quatNormalizeSkip = 0;
    world.quatNormalizeFast = false;

    cannon.GSSolver solver = cannon.GSSolver();

    lastCallTime = world.performance.now().toDouble();
    world.defaultContactMaterial.contactEquationStiffness = 1e9;
    world.defaultContactMaterial.contactEquationRelaxation = 4;

    solver.iterations = 20;
    solver.tolerance = 0.1;

    if (split) {
      world.solver = cannon.SplitSolver(solver);
    } else {
      world.solver = solver;
    }

    world.broadphase = cannon.NaiveBroadphase();
    world.allowSleep = true;
  }
}

class DieObject {
  three.Mesh? mesh;
  cannon.Body? body;
  int name = -1;

  DieObject({this.mesh, this.body, this.name = -1});

  void updatePosition(cannon.Vec3 p) {
    body?.position = p;
  }

  void updateQuaternion(cannon.Quaternion q) {
    body?.quaternion = q;
  }

  void updateVelocity(cannon.Vec3 v) {
    body?.velocity = v;
  }

  void updateAngularVelocity(cannon.Vec3 a) {
    body?.angularVelocity = a;
  }

  void update(dt) {
    if (body != null && mesh != null) {
      _logger.debug(dt.toString());

      mesh!.position.setFrom(body!.position.toVector3());
      mesh!.quaternion.setFrom(body!.quaternion.toQuaternion());
    }
  }
}

class ThrowResponse {
  final ThrowDice throwDice;

  ThrowResponse({required this.throwDice});

  factory ThrowResponse.fromJson(Map<String, dynamic> json) {
    _logger.debug('ThrowResponse', json['throwDice'].toString());
    return ThrowResponse(
      throwDice: ThrowDice.fromJson(json['throwDice'] as Map<String, dynamic>),
    );
  }
}

class ThrowDice {
  final Vector3 gravity;
  final Vector3 groundPosition;
  final List<Die> dice;

  ThrowDice(
      {required this.gravity,
      required this.groundPosition,
      required this.dice});

  factory ThrowDice.fromJson(Map<String, dynamic> json) {
    List<Die> dice = [];
    var j = json['dice'] as List<dynamic>;
    for (var die in j) {
      var p = die['position'];
      var q = die['quaternion'];
      var v = die['velocity'];
      var a = die['angularVelocity'];
      dice.add(Die(
        position: Vector3(
            x: p['x'] as double, y: p['y'] as double, z: p['z'] as double),
        quaternion: DieQuaternion(
          w: q['w'] as double,
          x: q['x'] as double,
          y: q['y'] as double,
          z: q['z'] as double,
        ),
        velocity: Vector3(
            x: v['x'] as double, y: v['y'] as double, z: v['z'] as double),
        angularVelocity: Vector3(
            x: a['x'] as double, y: a['y'] as double, z: a['z'] as double),
      ));
    }
    var g = json['gravity'];
    var gp = json['groundPosition'];
    return ThrowDice(
      gravity: Vector3(
          x: g['x'] as double, y: g['y'] as double, z: g['z'] as double),
      groundPosition: Vector3(
          x: gp['x'] as double, y: gp['y'] as double, z: gp['z'] as double),
      dice: dice,
    );
  }
}

enum Score {
  ones,
  twos,
  threes,
  fours,
  fives,
  sixes,
  pair,
  twopairs,
  threepairs,
  threeofakind,
  fourofakind,
  fiveofakind,
  smallstraight,
  largestraight,
  fullstraight,
  fullhouse,
  villa,
  tower,
  chance,
  maxiyatzy,
}
