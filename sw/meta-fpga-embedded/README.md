# FPGA Embedded Layer

This layer is designed to be a starting point for example designs and your own projects targeting Altera SoC FPGA Devkits. The layer uses [kas](https://github.com/siemens/kas) configuration files to provide a modular approach to building Linux images.

## Dependencies

### Kas
[kas](https://github.com/siemens/kas) is required to configure a build based on `meta-fpga-embedded`.

`kas` is a Python based tool and can be installed using `pip` directly or in a [Docker](https://www.docker.com/) container which avoids the need to also install required [Yocto build dependencies](https://docs.yoctoproject.org/2.2.2/ref-manual/ref-manual.html#required-packages-for-the-host-development-system).

We recommend using `kas` in a Docker container. If you don't currently have Docker installed follow the [official documentation](https://docs.docker.com/engine/install/) before running the below commands to pull down the `kas` helper script:

```bash
sudo wget https://github.com/siemens/kas/raw/refs/heads/master/kas-container -O /usr/bin/kas
sudo chmod +x /usr/bin/kas
```

[Read the official documentation](https://kas.readthedocs.io/en/latest/userguide/getting-started.html) for more information.

## Supported Machines

 - `agilex5_modular`
 - `agilex5_dk_a5e065bb32aes1`
 - `agilex7_dk_si_agf014ea`

## Supported Image Types

 - `mmc` (SD Card)

## Building A Minimal Image
To build a minimal SD card image for a given Devkit run the following commands:

```bash
KAS_MACHINE=${MACHINE} kas build meta-fpga-embedded/kas-fpga-embedded-core.yml
```

For example:

```bash
KAS_MACHINE=agilex5_modular kas build meta-fpga-embedded/kas-fpga-embedded-core.yml
```

See below for a list of supported `MACHINE` identifiers.

Once the build has finished successfully you will have a `.wic` image available in `build/tmp/deploy/images/${MACHINE}` which can be written to an SD card.

## Building A Custom Image
To use this layer to build your own custom image you will need to create a `kas` configuration file for your project. You can use [kas-example.yml](../kas-example.yml) provided in this repository as a starting point.
For more advanced projects you may also want to [create a dedicated Yocto layer](https://docs.yoctoproject.org/dev/dev-manual/layers.html) for your project in which case add the `kas` config file to the root of your project layer.

### Setting Up Your Project

The `kas` configuration YAML file is where you will add all of your project specfic configuration to customize your image. The most common configuration options are outlined in the following sections.

See [kas documentation](https://kas.readthedocs.io/en/latest/userguide/project-configuration.html) for more information.

### Updating Project Name
You can rename `kas-example.yml` to reflect the name of your project. For example `kas-${my_project_name}.yml`

Open your projects kas config file in your preferred text editor and update the `example_project` identifier in the `local_conf_header` section to reflect your project name.

## Configuration
The `fpga-embedded` layer is designed to be modular and configurable enabling you to build a bespoke image for your project easily and without additional bloat. The most common configuration options are outlined in the following sections.

### Core Configuration
The `core` config provided by [kas-fpga-embedded-core.yml](kas-fpga-embedded-core.yml) is required and should always be present in you project config `includes` section. This configuration file adds essential BSP related packages and other build environment parameters.

```
  includes:
    - repo: meta-fpga-embedded
      file: kas-fpga-embedded-core.yml
```

### Target Devkit
To configure your target machine add the following to your projects kas config file substituting `${MACHINE}` with one of the supported machine identifiers listed below:

```
machine: ${MACHINE}
```

For example to build for Agilex 5 Modular Devkit:

```
machine: agilex5_modular
```

> You can omit `machine` from your config file and simply use `KAS_MACHINE=${MACHINE}` when running `kas` commands if preferred 

### Optional Configuration
The `fpga-embedded` layer offers some optional `kas` configurations which can be included in your project config to add additional functionality to your image.

The current optional configs are detailed below.

#### Dev
The `Dev` configuration provides some essential tools for a developer focussed image including SSH access out-of-the-box and tools such as `devmem2` for probing memory addresses.

```
  includes:
    - repo: meta-fpga-embedded
      file: kas/dev.yml
```

#### Docker
The `Docker` configuration adds full [Docker](https://www.docker.com/) support to an image including the [containerd](https://containerd.io/) runtime and [Docker Compose](https://docs.docker.com/compose/) plugin.

```
  includes:
    - repo: meta-fpga-embedded
      file: kas/docker.yml
```
