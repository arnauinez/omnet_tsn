//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Lesser General Public License for more details.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with this program.  If not, see http://www.gnu.org/licenses/.
// 

package nesting.simulations.nestingStandardHost;

import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.node.ethernet.Eth1G;
import nesting.node.ethernet.VlanEtherSwitchPreemptable;
import nesting.node.nesting.NestingStandardHost;
import ned.DatarateChannel;

network Network
{
    @display("bgb=1820,1109");
    types:
        channel Cf extends DatarateChannel
        {
            datarate = 1000Mbps;
        }

        channel Cs extends DatarateChannel
        {
            datarate = 100Mbps;
        }
    submodules:
        configurator: Ipv4NetworkConfigurator {
            @display("is=s;p=31,30");
        }
        H0: NestingStandardHost {
            parameters:
                @display("p=597,207");
            gates:
                ethg[1];
        }
        H1: NestingStandardHost {
            parameters:
                @display("p=249,225");
            gates:
                ethg[1];
        }
        H2: NestingStandardHost {
            parameters:
                @display("p=249,874");
            gates:
                ethg[1];
        }
        H3: NestingStandardHost {
            @display("p=597,874");
            gates:
                ethg[1];
        }
        S0: NestingStandardHost {
            parameters:
                @display("p=1512,207");
            gates:
                ethg[1];
        }
        S1: NestingStandardHost {
            parameters:
                @display("p=1512,874");
            gates:
                ethg[1];
        }
        SW1: VlanEtherSwitchPreemptable {
            parameters:
                @display("p=597,561");
            gates:
                ethg[5];
        }
        SW2: VlanEtherSwitchPreemptable {
            parameters:
                @display("p=1269,561");
            gates:
                ethg[3];
        }
    connections:
        H0.ethg[0] <--> Cs <--> SW1.ethg[0];
        H1.ethg[0] <--> Cs <--> SW1.ethg[1];
        H2.ethg[0] <--> Cs <--> SW1.ethg[2];
        H3.ethg[0] <--> Cs <--> SW1.ethg[4];
        S0.ethg[0] <--> Cs <--> SW2.ethg[1];
        S1.ethg[0] <--> Cs <--> SW2.ethg[2];
        SW1.ethg[3] <--> Cf <--> SW2.ethg[0];
}
