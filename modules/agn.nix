{
  den,
  ...
}:
{
  den.aspects.agn = {
    includes = [
      den._.primary-user
      (den._.user-shell "fish")
    ];
  };
}
