{ inputs, ... }:
{
  imports = [
    # Meaning "Nucleus"
    (inputs.den.namespace "nawa" true)
  ];
}
