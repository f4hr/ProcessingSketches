/*
Palletes:
#1
  bg: #faf0ca
  fg: #0d3b66
#2
  bg: #00272b
  fg: #e0ff4f
*/

import java.util.Date;

int _framerate = 60;
int _maxFrames = 60 * 10;
int _dotsPerFrame = 2000;

color _c_bg = #00272b;
color _c_fg = #e0ff4f;
float _trailSpan = 0.125;

int _n = 0;
float _c = 16;

float _initAngle = 133.0;
float _angle = _initAngle;
float _angleInc = 0.01;
float _distanceToCorner;
float _minDotSize = 8;
float _maxDotSize = 12;

boolean _isEdge = false;
boolean _isStatic = false;
boolean _showAngle = true;

void setup() {
    size(640, 640, P2D);
    surface.setTitle(String.format("angle: %.2f", _angle));
    frameRate(_framerate);
    background(_c_bg);
    textSize(26);
    smooth(8);

    if (_showAngle) {
        fill(_c_fg);
        text(String.format("ANGLE: %.2f°", _angle), 10, 26);
    }

    _distanceToCorner = dist(0, 0, width / 2, height / 2);
}

void mousePressed() {
    saveFrame("dist/img/frame-" + (new Date()).getTime() + ".png");
}

void draw() {
    if (_angle >= 360.0) {
        _angle = 0.0;
    }

    if (_isEdge) {
        if (!_isStatic) {
            _angle += _angleInc;
        }
        fill(_c_bg, 255 * _trailSpan);
        rect(-1, -1, width + 1, height + 1);
        _n = 0;
        _isEdge = false;

        surface.setTitle(String.format("angle: %.2f", _angle));
        fill(_c_bg, 255);
        if (_showAngle) {
            rect(-1, -1, 200, 35);
            fill(_c_fg, 255);
            text(String.format("ANGLE: %.2f°", _angle), 10, 26);
        }
    }

    for (int i = 0; i < _dotsPerFrame; i += 1) {
        float a = _n * radians(_angle);
        float r = _c * sqrt(_n);

        float x = r * cos(a) + width / 2;
        float y = r * sin(a) + height / 2;
        float distanceToCenter = dist(x, y, width / 2, height / 2);
        float opacity = map(distanceToCenter, 0, width / 2, 0, 255);
        float seedSize = map(distanceToCenter, 0, width / 2, _minDotSize, _maxDotSize);
        float noiseAmt = map(distanceToCenter, 0, width / 2, 1, 0.99);

        stroke(_c_fg, 255 - opacity);
        strokeWeight(random(_minDotSize, seedSize));

        x = x * random(noiseAmt, 1);
        y = y * random(noiseAmt, 1);
        point(x, y);

        _n += 1;
        // _angleInc = map(cos(_angle), -1.0, 1.0, 0.001, 0.005); // speed up/down animation
        _c = map(sin(_angle), -1.0, 1.0, 20, 32); // zoom in/out animation

        _isEdge = distanceToCenter > width / 2;
    }


    // Save frames
    // if (frameCount <= _maxFrames) {
    //     saveFrame("dist/frames/frame-#####.png");
    // } else {
    //     exit();
    // }
}
