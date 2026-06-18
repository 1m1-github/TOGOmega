# TOGOmega

## Install julia

```
curl -fsSL https://install.julialang.org | sh
```

## Create directory

```
mkdir TheoryOfGod && cd TheoryOfGod
```

## Install

```
env JULIA_PROJECT=.tog JULIA_DEPOT_PATH=.tog/julia julia --optimize=3 --threads=auto --quiet --eval 'using Pkg
Pkg.Registry.add("General")
Pkg.Registry.add(url="https://github.com/1m1-github/TOGRegistry.git")
Pkg.add("TOGOmega")'
```

## Run

```
env JULIA_PKG_DEVDIR=$HOME/.julia/dev JULIA_PROJECT=.tog JULIA_DEPOT_PATH=.tog/julia julia --optimize=3 --threads=auto --interactive --quiet --eval 'using TOGOmega;TOGOmega.awaken()'
```

## Update

```
env JULIA_PROJECT=.tog JULIA_DEPOT_PATH=.tog/julia julia --optimize=3 --threads=auto --quiet --eval 'using Pkg;Pkg.update()'
```

## god

https://github.com/1m1-github/TOGgod.git
