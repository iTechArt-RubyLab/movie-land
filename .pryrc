# frozen_string_literal: true

Pry.config.prompt = Pry::Prompt[:rails]

Pry.config.collision_warning = true

Pry.commands.alias_command 'c', 'continue'
Pry.commands.alias_command 's', 'step'
Pry.commands.alias_command 'n', 'next'
