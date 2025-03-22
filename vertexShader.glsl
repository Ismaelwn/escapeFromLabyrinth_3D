// Vertex shader
#define PROCESSING_TEXTURE_SHADER

uniform mat4 transform;
uniform float realZ;

attribute vec4 position;
attribute vec4 color;
attribute vec2 texCoord;

varying vec4 vertColor;
varying float positionVert;
varying vec2 texCoordVar;

void main() {
  gl_Position = transform * position;
  vertColor = color;
  texCoordVar = texCoord;
  // on recupere le z pour l'envoyé au fragmentshader
  positionVert = position.z;
}


