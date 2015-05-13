#! /usr/local/bin/vvp
:ivl_version "0.10.0 (devel)" "(s20140801-15-g4ea512c)";
:ivl_delay_selection "TYPICAL";
:vpi_time_precision + 0;
:vpi_module "system";
:vpi_module "vhdl_sys";
:vpi_module "v2005_math";
:vpi_module "va_math";
S_0x8b87198 .scope module, "TestBench" "TestBench" 2 3;
 .timescale 0 0;
v0x8ba92a8_0 .var "A", 31 0;
v0x8ba9358_0 .var "Ack_Flag", 0 0;
v0x8ba93c0_0 .var "B", 31 0;
v0x8ba9450_0 .var "Clock", 0 0;
v0x8ba94a8_0 .net "Done", 0 0, v0x8ba8e50_0;  1 drivers
v0x8ba9500_0 .net "Idle", 0 0, v0x8ba8eb8_0;  1 drivers
v0x8ba9578_0 .var "Reset", 0 0;
v0x8ba95f0_0 .net "Result", 31 0, v0x8ba8940_0;  1 drivers
v0x8ba9680_0 .var "Valid_Data_Flag", 0 0;
E_0x8b778e0 .event posedge, v0x8ba8eb8_0;
E_0x8b87260 .event negedge, v0x8ba8e50_0;
E_0x8b87288 .event posedge, v0x8ba8e50_0;
S_0x8b85628 .scope module, "uut" "Multiplicator" 2 24, 3 16 0, S_0x8b87198;
 .timescale 0 0;
    .port_info 0 /INPUT 32 "iData_A"
    .port_info 1 /INPUT 32 "iData_B"
    .port_info 2 /INPUT 1 "Clock"
    .port_info 3 /INPUT 1 "Reset"
    .port_info 4 /INPUT 1 "iValid_Data"
    .port_info 5 /INPUT 1 "iAcknoledged"
    .port_info 6 /OUTPUT 1 "oDone"
    .port_info 7 /OUTPUT 1 "oIdle"
    .port_info 8 /OUTPUT 32 "oResult"
v0x8ba8bb8_0 .net "Clock", 0 0, v0x8ba9450_0;  1 drivers
v0x8ba8c58_0 .net "Reset", 0 0, v0x8ba9578_0;  1 drivers
v0x8ba8cc0_0 .net "iAcknoledged", 0 0, v0x8ba9358_0;  1 drivers
v0x8ba8d18_0 .net "iData_A", 31 0, v0x8ba92a8_0;  1 drivers
v0x8ba8d80_0 .net "iData_B", 31 0, v0x8ba93c0_0;  1 drivers
v0x8ba8df8_0 .net "iValid_Data", 0 0, v0x8ba9680_0;  1 drivers
v0x8ba8e50_0 .var "oDone", 0 0;
v0x8ba8eb8_0 .var "oIdle", 0 0;
v0x8ba8f20_0 .net "oResult", 31 0, v0x8ba8940_0;  alias, 1 drivers
v0x8ba8ff0_0 .var "rCounterReset", 0 0;
v0x8ba9068_0 .var "rCurrentState", 1 0;
v0x8ba90c0_0 .var "rData_Reset", 0 0;
v0x8ba9138_0 .var "rNextState", 1 0;
v0x8ba91a0_0 .net "wCounter", 4 0, v0x8ba84e0_0;  1 drivers
E_0x8b857b0 .event edge, v0x8ba9068_0, v0x8ba8df8_0, v0x8ba84e0_0, v0x8ba8cc0_0;
S_0x8b87e98 .scope module, "Counter_32b" "Counter" 3 43, 4 46 0, S_0x8b85628;
 .timescale 0 0;
    .port_info 0 /INPUT 1 "Clock"
    .port_info 1 /INPUT 1 "iCounterReset"
    .port_info 2 /OUTPUT 5 "oCounter"
P_0x8b87f88 .param/l "SIZE" 0 4 46, +C4<0101>;
v0x8b64ed0_0 .net "Clock", 0 0, v0x8ba9450_0;  alias, 1 drivers
v0x8ba8478_0 .net "iCounterReset", 0 0, v0x8ba8ff0_0;  1 drivers
v0x8ba84e0_0 .var "oCounter", 4 0;
E_0x8b87fd8 .event posedge, v0x8b64ed0_0;
S_0x8ba85a0 .scope module, "DataPath" "Data_Path" 3 56, 4 12 0, S_0x8b85628;
 .timescale 0 0;
    .port_info 0 /INPUT 32 "iData_A"
    .port_info 1 /INPUT 32 "iData_B"
    .port_info 2 /INPUT 1 "iData_Reset"
    .port_info 3 /INPUT 1 "Clock"
    .port_info 4 /OUTPUT 32 "oProduct"
v0x8ba86e8_0 .net "Clock", 0 0, v0x8ba9450_0;  alias, 1 drivers
v0x8ba8760_0 .net "add_sel", 0 0, L_0x8ba9720;  1 drivers
v0x8ba87b8_0 .net "iData_A", 31 0, v0x8ba92a8_0;  alias, 1 drivers
v0x8ba8838_0 .net "iData_B", 31 0, v0x8ba93c0_0;  alias, 1 drivers
v0x8ba88b0_0 .net "iData_Reset", 0 0, v0x8ba90c0_0;  1 drivers
v0x8ba8940_0 .var "oProduct", 31 0;
v0x8ba89b8_0 .var "reg_A", 31 0;
v0x8ba8a30_0 .var "reg_B", 31 0;
v0x8ba8aa8_0 .var "wTmp_Sum", 31 0;
L_0x8ba9720 .part v0x8ba8a30_0, 0, 1;
    .scope S_0x8b87e98;
T_0 ;
    %wait E_0x8b87fd8;
    %load/v 8, v0x8ba8478_0, 1;
    %jmp/0xz  T_0.0, 8;
    %set/v v0x8ba84e0_0, 0, 5;
    %jmp T_0.1;
T_0.0 ;
    %ix/load 0, 1, 0;
    %load/vp0 8, v0x8ba84e0_0, 5;
    %set/v v0x8ba84e0_0, 8, 5;
T_0.1 ;
    %jmp T_0;
    .thread T_0;
    .scope S_0x8ba85a0;
T_1 ;
    %wait E_0x8b87fd8;
    %load/v 8, v0x8ba8760_0, 1;
    %inv 8, 1;
    %jmp/0  T_1.0, 8;
    %load/v 9, v0x8ba8940_0, 32;
    %jmp/1  T_1.2, 8;
T_1.0 ; End of true expr.
    %load/v 41, v0x8ba8940_0, 32;
    %load/v 73, v0x8ba89b8_0, 32;
    %add 41, 73, 32;
    %jmp/0  T_1.1, 8;
 ; End of false expr.
    %blend  9, 41, 32; Condition unknown.
    %jmp  T_1.2;
T_1.1 ;
    %mov 9, 41, 32; Return false value
T_1.2 ;
    %set/v v0x8ba8aa8_0, 9, 32;
    %load/v 8, v0x8ba88b0_0, 1;
    %jmp/0  T_1.3, 8;
    %mov 9, 0, 32;
    %jmp/1  T_1.5, 8;
T_1.3 ; End of true expr.
    %load/v 41, v0x8ba8aa8_0, 32;
    %jmp/0  T_1.4, 8;
 ; End of false expr.
    %blend  9, 41, 32; Condition unknown.
    %jmp  T_1.5;
T_1.4 ;
    %mov 9, 41, 32; Return false value
T_1.5 ;
    %set/v v0x8ba8940_0, 9, 32;
    %load/v 8, v0x8ba88b0_0, 1;
    %jmp/0  T_1.6, 8;
    %load/v 9, v0x8ba8838_0, 32;
    %jmp/1  T_1.8, 8;
T_1.6 ; End of true expr.
    %load/v 41, v0x8ba8a30_0, 32;
    %ix/load 0, 1, 0;
    %mov 4, 0, 1;
    %shiftr/i0  41, 32;
    %jmp/0  T_1.7, 8;
 ; End of false expr.
    %blend  9, 41, 32; Condition unknown.
    %jmp  T_1.8;
T_1.7 ;
    %mov 9, 41, 32; Return false value
T_1.8 ;
    %set/v v0x8ba8a30_0, 9, 32;
    %load/v 8, v0x8ba88b0_0, 1;
    %jmp/0  T_1.9, 8;
    %load/v 9, v0x8ba87b8_0, 32;
    %jmp/1  T_1.11, 8;
T_1.9 ; End of true expr.
    %load/v 41, v0x8ba89b8_0, 32;
    %ix/load 0, 1, 0;
    %mov 4, 0, 1;
    %shiftl/i0  41, 32;
    %jmp/0  T_1.10, 8;
 ; End of false expr.
    %blend  9, 41, 32; Condition unknown.
    %jmp  T_1.11;
T_1.10 ;
    %mov 9, 41, 32; Return false value
T_1.11 ;
    %set/v v0x8ba89b8_0, 9, 32;
    %jmp T_1;
    .thread T_1;
    .scope S_0x8b85628;
T_2 ;
    %wait E_0x8b87fd8;
    %load/v 8, v0x8ba8c58_0, 1;
    %jmp/0xz  T_2.0, 8;
    %set/v v0x8ba9068_0, 0, 2;
    %jmp T_2.1;
T_2.0 ;
    %load/v 8, v0x8ba9138_0, 2;
    %set/v v0x8ba9068_0, 8, 2;
T_2.1 ;
    %jmp T_2;
    .thread T_2;
    .scope S_0x8b85628;
T_3 ;
    %wait E_0x8b857b0;
    %load/v 8, v0x8ba9068_0, 2;
    %cmpi/u 8, 0, 2;
    %jmp/1 T_3.0, 6;
    %cmpi/u 8, 1, 2;
    %jmp/1 T_3.1, 6;
    %cmpi/u 8, 2, 2;
    %jmp/1 T_3.2, 6;
    %cmpi/u 8, 3, 2;
    %jmp/1 T_3.3, 6;
    %jmp T_3.4;
T_3.0 ;
    %movi 8, 1, 2;
    %set/v v0x8ba9138_0, 8, 2;
    %set/v v0x8ba90c0_0, 1, 1;
    %set/v v0x8ba8ff0_0, 1, 1;
    %set/v v0x8ba8e50_0, 0, 1;
    %set/v v0x8ba8eb8_0, 0, 1;
    %jmp T_3.4;
T_3.1 ;
    %load/v 8, v0x8ba8df8_0, 1;
    %jmp/0  T_3.5, 8;
    %movi 9, 2, 2;
    %jmp/1  T_3.7, 8;
T_3.5 ; End of true expr.
    %movi 11, 1, 2;
    %jmp/0  T_3.6, 8;
 ; End of false expr.
    %blend  9, 11, 2; Condition unknown.
    %jmp  T_3.7;
T_3.6 ;
    %mov 9, 11, 2; Return false value
T_3.7 ;
    %set/v v0x8ba9138_0, 9, 2;
    %set/v v0x8ba8ff0_0, 1, 1;
    %set/v v0x8ba90c0_0, 1, 1;
    %set/v v0x8ba8e50_0, 0, 1;
    %set/v v0x8ba8eb8_0, 1, 1;
    %jmp T_3.4;
T_3.2 ;
    %load/v 8, v0x8ba91a0_0, 5;
    %cmpi/u 8, 31, 5;
    %mov 8, 4, 1;
    %jmp/0  T_3.8, 8;
    %mov 9, 1, 2;
    %jmp/1  T_3.10, 8;
T_3.8 ; End of true expr.
    %movi 11, 2, 2;
    %jmp/0  T_3.9, 8;
 ; End of false expr.
    %blend  9, 11, 2; Condition unknown.
    %jmp  T_3.10;
T_3.9 ;
    %mov 9, 11, 2; Return false value
T_3.10 ;
    %set/v v0x8ba9138_0, 9, 2;
    %load/v 8, v0x8ba91a0_0, 5;
    %cmpi/u 8, 0, 5;
    %mov 8, 4, 1;
    %jmp/0  T_3.11, 8;
    %movi 9, 1, 2;
    %jmp/1  T_3.13, 8;
T_3.11 ; End of true expr.
    %jmp/0  T_3.12, 8;
 ; End of false expr.
    %blend  9, 0, 2; Condition unknown.
    %jmp  T_3.13;
T_3.12 ;
    %mov 9, 0, 2; Return false value
T_3.13 ;
    %set/v v0x8ba90c0_0, 9, 1;
    %set/v v0x8ba8ff0_0, 0, 1;
    %set/v v0x8ba8e50_0, 0, 1;
    %set/v v0x8ba8eb8_0, 0, 1;
    %jmp T_3.4;
T_3.3 ;
    %load/v 8, v0x8ba8cc0_0, 1;
    %jmp/0  T_3.14, 8;
    %movi 9, 1, 2;
    %jmp/1  T_3.16, 8;
T_3.14 ; End of true expr.
    %jmp/0  T_3.15, 8;
 ; End of false expr.
    %blend  9, 1, 2; Condition unknown.
    %jmp  T_3.16;
T_3.15 ;
    %mov 9, 1, 2; Return false value
T_3.16 ;
    %set/v v0x8ba9138_0, 9, 2;
    %set/v v0x8ba90c0_0, 0, 1;
    %set/v v0x8ba8ff0_0, 1, 1;
    %set/v v0x8ba8e50_0, 1, 1;
    %set/v v0x8ba8eb8_0, 0, 1;
    %jmp T_3.4;
T_3.4 ;
    %jmp T_3;
    .thread T_3, $push;
    .scope S_0x8b87198;
T_4 ;
    %load/v 8, v0x8ba9450_0, 1;
    %jmp/0xz  T_4.0, 8;
    %delay 5, 0;
    %set/v v0x8ba9450_0, 0, 1;
    %jmp T_4.1;
T_4.0 ;
    %delay 5, 0;
    %set/v v0x8ba9450_0, 1, 1;
T_4.1 ;
    %jmp T_4;
    .thread T_4;
    .scope S_0x8b87198;
T_5 ;
    %wait E_0x8b87288;
    %delay 50, 0;
    %set/v v0x8ba9358_0, 1, 1;
    %jmp T_5;
    .thread T_5;
    .scope S_0x8b87198;
T_6 ;
    %wait E_0x8b87260;
    %delay 50, 0;
    %set/v v0x8ba9358_0, 0, 1;
    %jmp T_6;
    .thread T_6;
    .scope S_0x8b87198;
T_7 ;
    %wait E_0x8b778e0;
    %ix/load 0, 1, 0;
    %load/vp0 8, v0x8ba92a8_0, 32;
    %ix/load 0, 32, 0;
    %assign/v0 v0x8ba92a8_0, 0, 8;
    %ix/load 0, 1, 0;
    %load/vp0 8, v0x8ba93c0_0, 32;
    %ix/load 0, 32, 0;
    %assign/v0 v0x8ba93c0_0, 0, 8;
    %delay 500, 0;
    %ix/load 0, 1, 0;
    %assign/v0 v0x8ba9680_0, 0, 1;
    %delay 100, 0;
    %ix/load 0, 1, 0;
    %assign/v0 v0x8ba9680_0, 0, 0;
    %jmp T_7;
    .thread T_7;
    .scope S_0x8b87198;
T_8 ;
    %vpi_call 2 62 "$dumpfile", "Waves.vcd" {0 0};
    %vpi_call 2 63 "$dumpvars" {0 0};
    %delay 5, 0;
    %set/v v0x8ba9450_0, 0, 1;
    %set/v v0x8ba9578_0, 0, 1;
    %set/v v0x8ba9358_0, 0, 1;
    %set/v v0x8ba9680_0, 0, 1;
    %movi 8, 1, 32;
    %set/v v0x8ba92a8_0, 8, 32;
    %movi 8, 1, 32;
    %set/v v0x8ba93c0_0, 8, 32;
    %delay 15, 0;
    %set/v v0x8ba9578_0, 1, 1;
    %delay 80, 0;
    %set/v v0x8ba9578_0, 0, 1;
    %delay 5000, 0;
    %vpi_call 2 76 "$finish" {0 0};
    %end;
    .thread T_8;
# The file index is used to find the file name in the following table.
:file_names 5;
    "N/A";
    "<interactive>";
    "TestBench.v";
    "./Mult_Controller.v";
    "./Collaterals.v";
