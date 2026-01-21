public static var camMc:FlxCamera;

var skinType = 'Default';
var catY = 300;
var catX = 0;
var catScale = 0.2;

var sprites:Map<String, FlxSprite> = [];

function postCreate() {
	FlxG.cameras.add(camMc = new FlxCamera(), false);
	camMc.bgColor = 0x00;

	var types = ['base', 'up', 'down', 'left', 'right', 'upright', 'leftdown', 'base_left', 'base_right'];

	for (type in types) {
		var sprite = new FlxSprite(catX, catY);
		sprite.loadGraphic(Paths.image('ManiaCat/' + skinType + '/' + type));
		sprite.scale.set(catScale, catScale);
		sprite.updateHitbox();
		sprite.cameras = [camMc];
		sprite.visible = (type == 'base');
		add(sprite);
		sprites.set(type, sprite);
	}
}

function update(elapsed:Float) {
	var upPressed = false;
	var downPressed = false;
	var leftPressed = false;
	var rightPressed = false;

	if (hitbox != null) {
		if (hitbox.buttonUp != null) upPressed = hitbox.buttonUp.pressed;
		if (hitbox.buttonDown != null) downPressed = hitbox.buttonDown.pressed;
		if (hitbox.buttonLeft != null) leftPressed = hitbox.buttonLeft.pressed;
		if (hitbox.buttonRight != null) rightPressed = hitbox.buttonRight.pressed;
	}

	for (sprite in sprites) sprite.visible = false;
	sprites['base'].visible = true;

	if (upPressed && rightPressed) {
		sprites['upright'].visible = true;
	} else if (leftPressed && downPressed) {
		sprites['leftdown'].visible = true;
	} else {
		if (upPressed) sprites['up'].visible = true;
		if (downPressed) sprites['down'].visible = true;
		if (leftPressed) sprites['left'].visible = true;
		if (rightPressed) sprites['right'].visible = true;
	}

	if (!upPressed && !rightPressed) sprites['base_right'].visible = true;
	if (!leftPressed && !downPressed) sprites['base_left'].visible = true;
}