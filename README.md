# Godot State Machine

A simple and flexible **Godot state machine** addon for organizing game logic using states.

## Overview

This addon provides two main classes:
- **StateMachine**: Inherits from `State` and can perform all state operations, as well as manage transitions between states.
- **State**: A base class for defining individual states, offering a set of methods for state logic.

## How It Works

To drive a `StateMachine` instance, the parent node must call the `_process_control` and `_physics_control` methods, passing the `delta` value. This is typically done from the parent node's `_process` and `_physics_process` functions:

```gdscript
func _process(delta: float) -> void:
    state_machine._process_control(delta)

func _physics_process(delta: float) -> void:
    state_machine._physics_control(delta)
```

**Note:**
- State identification is based on the node's name in the editor. Names are compared in lowercase (using `to_lower()`), with no other transformation applied.
- The `StateMachine` can be nested or used as a standalone node.

## Installation

1. **Clone or Download** this repository.
2. Move the contents of the `Addons` folder into your Godot project's `addons` directory (or copy the entire folder).
3. (Optional) Copy the `script_templates` folder to your project root, or merge its contents with your existing `script_templates` folder for quick script creation.

## Usage

- Attach the `StateMachine` node to your scene.
- Add child nodes inheriting from `State` for each state you want to define.
- Use the node names to reference and switch between states.
- Call the control methods as shown above from your parent node.

## Features
- Lightweight and easy to integrate.
- Supports both process and physics process flows.
- Includes script templates for rapid state and state machine creation.

## Example

```gdscript
# Example parent node script
@onready var state_machine: StateMachine = $"StateMachine"

func _ready():
    pass

func _process(delta: float) -> void:
    state_machine._process_control(delta)

func _physics_process(delta: float) -> void:
    state_machine._physics_control(delta)
```

## License
MIT

---

For more details, see the included script templates and example scenes.
