# ansible-farm-discover

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
![GitHub all releases](https://img.shields.io/github/downloads/rgglez/ansible-farm-discover/total) 
![GitHub issues](https://img.shields.io/github/issues/rgglez/ansible-farm-discover) 
![GitHub commit activity](https://img.shields.io/github/commit-activity/y/rgglez/ansible-farm-discover)

This perl script discovers the hosts in a subnet using [nmap](https://nmap.org/), and creates an ansible inventory for them. This can be useful in the case of an autoscaling farm of AWS EC2 or Aliyun ECS instances.

You can modify the name of the output file, and you need to modify the subnetworks to be scanned, by using the **--networks** and **--file** parameters:

```bash
perl discover.pl --networks="192.168.0.0/24 10.0.1.0/24" --file=farm.yaml
```

## Dependencies

* [Getopt::Long](https://perldoc.perl.org/Getopt::Long)

## License

Copyright (c) 2023 Rodolfo González González.

See the LICENSE file.
