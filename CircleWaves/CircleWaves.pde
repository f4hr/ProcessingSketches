int _framerate = 60;
int _maxFrames = _framerate * 10;

int _rowsCount;
int _itemsInRow = 15;
float _d; // diameter
float _r; // radius
float _globalXOffset = 0.75;
float _globalYOffset = 0.75;
float _initalAngle = 0.0;
float _angle = _initalAngle;
float _angleInc = 5.0;
float _angleOffsetInc = 0.125;

PVector[] _items;

void setup() {
    size(640, 640, P3D);
    frameRate(_framerate);
    background(0);
    smooth(8);
    noStroke();

    _d = width / _itemsInRow;
    _r = _d / 2;
    _rowsCount = _itemsInRow;
    _items = new PVector[_rowsCount];

    for (int i = 0; i < _items.length; i += 1) {
        float xOffset = width / 2 - (_rowsCount * _r * _globalXOffset);
        float yOffset = height / 2 - (_rowsCount * _r * _globalYOffset);
        _items[i] = new PVector(_d * i * _globalXOffset + xOffset, yOffset);
    }
}

void draw() {
    background(0);

    if (_angle >= 360.0) _angle = 0.0;

    float angleOffset = 0.0;
    float rad = radians(_angle);

    for (int j = 0; j < _rowsCount; j += 1) {

        boolean isEven = j % 2 == 0;
        for (int i = 0; i < _items.length; i += 1) {

            float angleWithOffset = rad + 0.25 * i + angleOffset;
            float x = sin(angleWithOffset) * (_r / 2);
            float y = cos(angleWithOffset) * (_r / 2);
            float colorShift = map(sin(angleWithOffset), -1, 1, 80, 220);
            float rowOffset = (isEven) ? 0 : _r;

            float xOffset = _items[i].x + x + rowOffset;
            float yOffset = _items[i].y + y + (_d * j * _globalYOffset);

            fill(colorShift, 255);
            ellipse(xOffset, yOffset, _d, _d);
        }
        angleOffset += _angleOffsetInc;
    }
    _angle += _angleInc;

    // Save frames
    // if (frameCount <= _maxFrames) {
    //     saveFrame("dist/frames/frame-#####.png");
    // } else {
    //     exit();
    // }
}
