#version 330

layout (location = 0) in uint inVertexCoord;
layout (location = 1) in vec3 inTextureCoord;

uniform vec3 chunkPosition;

uniform mat4 projectionViewMatrix;
uniform float time;

out vec3 passTexCoord;
out float passBasicLight;

vec4 createWaveOffset(vec3 position)
{
    position.y += sin((time + position.x) * 1.5) / 8.8f;
    position.y += cos((time + position.z) * 1.5) / 8.1f;
    position.y -= 0.22;
    return vec4(position, 1.0);
}

void main() {
    float x = float(inVertexCoord & 0x3Fu);
    float y = float((inVertexCoord & 0xFC0u) >> 6u);
    float z = float((inVertexCoord & 0x3F000u) >> 12u);
    x += chunkPosition.x;
    y += chunkPosition.y;
    z += chunkPosition.z;

    vec4 position = createWaveOffset(vec3(x, y, z));

    gl_Position = projectionViewMatrix * position;
    
    passTexCoord = inTextureCoord;
    passBasicLight = float((inVertexCoord & 0x1C0000u) >> 18u) / 5.0f;
}