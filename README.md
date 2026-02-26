Particle Celebration Demo (Flutter)

A Flutter demo that shows a particle explosion when a task is completed. Pressing the Complete Task button triggers colorful particles that animate outward for 10 seconds.

Features

Button-triggered particle animation

50 randomly generated particles per click

Random colors, sizes, speeds, and directions

Animation lasts 10 seconds and disappears automatically

Uses CustomPainter and AnimationController

How It Works

User clicks Complete Task

Old animation stops and resets

New particles are generated

Animation starts and updates every frame

After 10 seconds, particles disappear

Particles move using trigonometry:

dx = cos(direction) * speed * progress * 200
dy = sin(direction) * speed * progress * 200

CustomPainter draws each particle on the canvas every frame.

How to Run

Create a Flutter project:

flutter create particle_demo

Replace lib/main.dart with the demo code

Run:

flutter run
Concepts Demonstrated

Stateful widgets

AnimationController

CustomPainter

Canvas drawing

Basic particle motion using math