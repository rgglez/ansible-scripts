#!/usr/bin/perl

# Discover the hosts in a subnet, and create an ansible inventory for them.
# Copyright (C) 2023 Rodolfo González González.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

use Getopt::Long;

# get parameters...

$networks = "";
$file = "farm.yaml";

@subnets = qw(10.0.1.0/24);

GetOptions ("networks=s" => \$networks,
            "file=s" => \$file)
or die("Error in command line arguments\n");

# scan subnetworks...

if ($networks ne "") {
   @subnets = split(/ /, $networks);
}

@output = ();
foreach (@subnets) {
   print "Scanning $_\n";
   my @tmp = `nmap -sP $_`;
   @output = (@output, @tmp);
}

# store active servers...

open(F, ">$file");

print F "Farm:\n";
print F "  hosts:\n";

my $i = 0;
foreach (@output) {
   chomp($_);
   if ($_ =~ /(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})/) {
      print F "    host_$i:\n";
      print F "      ansible_host: $1\n";
      $i = $i + 1;
   }
}

# you can define ansible vars here, such as the username and 
# the key to login to the farm. This is optional.

print F "  vars:\n";
print F "    ansible_user: ecs-user\n";
print F "    become: yes\n";
print F "    become_user: root\n";
print F "    become_method: sudo -i\n";
print F "    ansible_ssh_private_key_file: ~/.ssh/ssh_key.pem\n";

close(F);

print "The End.\n";
