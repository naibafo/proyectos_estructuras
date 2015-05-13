#! /usr/local/bin/vvp
:ivl_version "0.10.0 (devel)" "(s20140801-15-g4ea512c)";
:ivl_delay_selection "TYPICAL";
:vpi_time_precision + 0;
:vpi_module "system";
:vpi_module "vhdl_sys";
:vpi_module "v2005_math";
:vpi_module "va_math";
S_0x9deec00 .scope module, "automatic_verificator_tb" "automatic_verificator_tb" 2 51;
 .timescale 0 0;
v0x9e11260_0 .var "A", 31 0;
v0x9e112d8_0 .var "Ack_Flag", 0 0;
v0x9e11378_0 .var "B", 31 0;
v0x9e113d0_0 .var "Clock", 0 0;
RS_0x9df3e94 .resolv tri, v0x9e103b0_0, v0x9e110a0_0;
v0x9e11428_0 .net8 "Done", 0 0, RS_0x9df3e94;  2 drivers
RS_0x9df3eac .resolv tri, v0x9e10418_0, v0x9e110f8_0;
v0x9e114b8_0 .net8 "Idle", 0 0, RS_0x9df3eac;  2 drivers
v0x9e11548_0 .var "Reset", 0 0;
v0x9e115a0_0 .net "Result_dut", 63 0, v0x9e0fea0_0;  1 drivers
v0x9e115f8_0 .net "Result_nut", 63 0, v0x9e11150_0;  1 drivers
v0x9e116e0_0 .var "Valid_Data_Flag", 0 0;
v0x9e11770_0 .net "is_all_good", 0 0, v0x9e10a00_0;  1 drivers
E_0x9ddc018 .event posedge, v0x9e10418_0;
E_0x9deecc8 .event negedge, v0x9e103b0_0;
E_0x9deecf0 .event posedge, v0x9e103b0_0;
S_0x9de9350 .scope module, "dut" "Multiplicator" 2 72, 3 16 0, S_0x9deec00;
 .timescale 0 0;
    .port_info 0 /INPUT 32 "iData_A"
    .port_info 1 /INPUT 32 "iData_B"
    .port_info 2 /INPUT 1 "Clock"
    .port_info 3 /INPUT 1 "Reset"
    .port_info 4 /INPUT 1 "iValid_Data"
    .port_info 5 /INPUT 1 "iAcknoledged"
    .port_info 6 /OUTPUT 1 "oDone"
    .port_info 7 /OUTPUT 1 "oIdle"
    .port_info 8 /OUTPUT 64 "oResult"
v0x9e10118_0 .net "Clock", 0 0, v0x9e113d0_0;  1 drivers
v0x9e101b8_0 .net "Reset", 0 0, v0x9e11548_0;  1 drivers
v0x9e10220_0 .net "iAcknoledged", 0 0, v0x9e112d8_0;  1 drivers
v0x9e10278_0 .net "iData_A", 31 0, v0x9e11260_0;  1 drivers
v0x9e102e0_0 .net "iData_B", 31 0, v0x9e11378_0;  1 drivers
v0x9e10358_0 .net "iValid_Data", 0 0, v0x9e116e0_0;  1 drivers
v0x9e103b0_0 .var "oDone", 0 0;
v0x9e10418_0 .var "oIdle", 0 0;
v0x9e10480_0 .net "oResult", 63 0, v0x9e0fea0_0;  alias, 1 drivers
v0x9e10550_0 .var "rCounterReset", 0 0;
v0x9e105c8_0 .var "rCurrentState", 1 0;
v0x9e10620_0 .var "rData_Reset", 0 0;
v0x9e10698_0 .var "rNextState", 1 0;
v0x9e10700_0 .net "wCounter", 4 0, v0x9e0fa40_0;  1 drivers
E_0x9de9468 .event edge, v0x9e105c8_0, v0x9e10358_0, v0x9e0fa40_0, v0x9e10220_0;
S_0x9de7640 .scope module, "Counter_32b" "Counter" 3 43, 4 46 0, S_0x9de9350;
 .timescale 0 0;
    .port_info 0 /INPUT 1 "Clock"
    .port_info 1 /INPUT 1 "iCounterReset"
    .port_info 2 /OUTPUT 5 "oCounter"
P_0x9de7730 .param/l "SIZE" 0 4 46, +C4<0101>;
v0x9dd8418_0 .net "Clock", 0 0, v0x9e113d0_0;  alias, 1 drivers
v0x9e0f9d8_0 .net "iCounterReset", 0 0, v0x9e10550_0;  1 drivers
v0x9e0fa40_0 .var "oCounter", 4 0;
E_0x9de7780 .event posedge, v0x9dd8418_0;
S_0x9e0fb00 .scope module, "DataPath" "Data_Path" 3 56, 4 12 0, S_0x9de9350;
 .timescale 0 0;
    .port_info 0 /INPUT 32 "iData_A"
    .port_info 1 /INPUT 32 "iData_B"
    .port_info 2 /INPUT 1 "iData_Reset"
    .port_info 3 /INPUT 1 "Clock"
    .port_info 4 /OUTPUT 64 "oProduct"
v0x9e0fc48_0 .net "Clock", 0 0, v0x9e113d0_0;  alias, 1 drivers
v0x9e0fcc0_0 .net "add_sel", 0 0, L_0x9e117c8;  1 drivers
v0x9e0fd18_0 .net "iData_A", 31 0, v0x9e11260_0;  alias, 1 drivers
v0x9e0fd98_0 .net "iData_B", 31 0, v0x9e11378_0;  alias, 1 drivers
v0x9e0fe10_0 .net "iData_Reset", 0 0, v0x9e10620_0;  1 drivers
v0x9e0fea0_0 .var "oProduct", 63 0;
v0x9e0ff18_0 .var "reg_A", 63 0;
v0x9e0ff90_0 .var "reg_B", 31 0;
v0x9e10008_0 .var "wTmp_Sum", 63 0;
L_0x9e117c8 .part v0x9e0ff90_0, 0, 1;
S_0x9e10808 .scope module, "dut_nut_comparator" "verificator" 2 98, 2 3 0, S_0x9deec00;
 .timescale 0 0;
    .port_info 0 /INPUT 64 "iR_dut"
    .port_info 1 /INPUT 64 "iR_nut"
    .port_info 2 /INPUT 1 "Clock"
    .port_info 3 /INPUT 1 "Reset"
    .port_info 4 /OUTPUT 1 "good"
v0x9e10920_0 .net "Clock", 0 0, v0x9e113d0_0;  alias, 1 drivers
v0x9e10978_0 .net "Reset", 0 0, v0x9e11548_0;  alias, 1 drivers
v0x9e10a00_0 .var "good", 0 0;
v0x9e10a70_0 .net "iR_dut", 63 0, v0x9e0fea0_0;  alias, 1 drivers
v0x9e10b00_0 .net "iR_nut", 63 0, v0x9e11150_0;  alias, 1 drivers
S_0x9e10be0 .scope module, "nut" "Conductual_Multiplicator" 2 85, 2 22 0, S_0x9deec00;
 .timescale 0 0;
    .port_info 0 /INPUT 32 "iData_A"
    .port_info 1 /INPUT 32 "iData_B"
    .port_info 2 /INPUT 1 "Clock"
    .port_info 3 /INPUT 1 "Reset"
    .port_info 4 /INPUT 1 "iValid_Data"
    .port_info 5 /INPUT 1 "iAcknoledged"
    .port_info 6 /OUTPUT 1 "oDone"
    .port_info 7 /OUTPUT 1 "oIdle"
    .port_info 8 /OUTPUT 64 "oResult"
v0x9e10d68_0 .net "Clock", 0 0, v0x9e113d0_0;  alias, 1 drivers
v0x9e10e28_0 .net "Reset", 0 0, v0x9e11548_0;  alias, 1 drivers
v0x9e10e90_0 .net "iAcknoledged", 0 0, v0x9e112d8_0;  alias, 1 drivers
v0x9e10f00_0 .net "iData_A", 31 0, v0x9e11260_0;  alias, 1 drivers
v0x9e10f90_0 .net "iData_B", 31 0, v0x9e11378_0;  alias, 1 drivers
v0x9e11048_0 .net "iValid_Data", 0 0, v0x9e116e0_0;  alias, 1 drivers
v0x9e110a0_0 .var "oDone", 0 0;
v0x9e110f8_0 .var "oIdle", 0 0;
v0x9e11150_0 .var "oResult", 63 0;
    .scope S_0x9de7640;
T_0 ;
    %wait E_0x9de7780;
    %load/v 8, v0x9e0f9d8_0, 1;
    %jmp/0xz  T_0.0, 8;
    %set/v v0x9e0fa40_0, 0, 5;
    %jmp T_0.1;
T_0.0 ;
    %ix/load 0, 1, 0;
    %load/vp0 8, v0x9e0fa40_0, 5;
    %set/v v0x9e0fa40_0, 8, 5;
T_0.1 ;
    %jmp T_0;
    .thread T_0;
    .scope S_0x9e0fb00;
T_1 ;
    %wait E_0x9de7780;
    %load/v 8, v0x9e0fcc0_0, 1;
    %inv 8, 1;
    %jmp/0  T_1.0, 8;
    %load/v 9, v0x9e0fea0_0, 64;
    %jmp/1  T_1.2, 8;
T_1.0 ; End of true expr.
    %load/v 73, v0x9e0fea0_0, 64;
    %load/v 137, v0x9e0ff18_0, 64;
    %add 73, 137, 64;
    %jmp/0  T_1.1, 8;
 ; End of false expr.
    %blend  9, 73, 64; Condition unknown.
    %jmp  T_1.2;
T_1.1 ;
    %mov 9, 73, 64; Return false value
T_1.2 ;
    %set/v v0x9e10008_0, 9, 64;
    %load/v 8, v0x9e0fe10_0, 1;
    %jmp/0  T_1.3, 8;
    %mov 9, 0, 64;
    %jmp/1  T_1.5, 8;
T_1.3 ; End of true expr.
    %load/v 73, v0x9e10008_0, 64;
    %jmp/0  T_1.4, 8;
 ; End of false expr.
    %blend  9, 73, 64; Condition unknown.
    %jmp  T_1.5;
T_1.4 ;
    %mov 9, 73, 64; Return false value
T_1.5 ;
    %set/v v0x9e0fea0_0, 9, 64;
    %load/v 8, v0x9e0fe10_0, 1;
    %jmp/0  T_1.6, 8;
    %load/v 9, v0x9e0fd98_0, 32;
    %jmp/1  T_1.8, 8;
T_1.6 ; End of true expr.
    %load/v 41, v0x9e0ff90_0, 32;
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
    %set/v v0x9e0ff90_0, 9, 32;
    %load/v 8, v0x9e0fe10_0, 1;
    %jmp/0  T_1.9, 8;
    %load/v 9, v0x9e0fd18_0, 32;
    %mov 41, 0, 32;
    %jmp/1  T_1.11, 8;
T_1.9 ; End of true expr.
    %load/v 73, v0x9e0ff18_0, 64;
    %ix/load 0, 1, 0;
    %mov 4, 0, 1;
    %shiftl/i0  73, 64;
    %jmp/0  T_1.10, 8;
 ; End of false expr.
    %blend  9, 73, 64; Condition unknown.
    %jmp  T_1.11;
T_1.10 ;
    %mov 9, 73, 64; Return false value
T_1.11 ;
    %set/v v0x9e0ff18_0, 9, 64;
    %jmp T_1;
    .thread T_1;
    .scope S_0x9de9350;
T_2 ;
    %wait E_0x9de7780;
    %load/v 8, v0x9e101b8_0, 1;
    %jmp/0xz  T_2.0, 8;
    %set/v v0x9e105c8_0, 0, 2;
    %jmp T_2.1;
T_2.0 ;
    %load/v 8, v0x9e10698_0, 2;
    %set/v v0x9e105c8_0, 8, 2;
T_2.1 ;
    %jmp T_2;
    .thread T_2;
    .scope S_0x9de9350;
T_3 ;
    %wait E_0x9de9468;
    %load/v 8, v0x9e105c8_0, 2;
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
    %set/v v0x9e10698_0, 8, 2;
    %set/v v0x9e10620_0, 1, 1;
    %set/v v0x9e10550_0, 1, 1;
    %set/v v0x9e103b0_0, 0, 1;
    %set/v v0x9e10418_0, 0, 1;
    %jmp T_3.4;
T_3.1 ;
    %load/v 8, v0x9e10358_0, 1;
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
    %set/v v0x9e10698_0, 9, 2;
    %set/v v0x9e10550_0, 1, 1;
    %set/v v0x9e10620_0, 1, 1;
    %set/v v0x9e103b0_0, 0, 1;
    %set/v v0x9e10418_0, 1, 1;
    %jmp T_3.4;
T_3.2 ;
    %load/v 8, v0x9e10700_0, 5;
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
    %set/v v0x9e10698_0, 9, 2;
    %load/v 8, v0x9e10700_0, 5;
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
    %set/v v0x9e10620_0, 9, 1;
    %set/v v0x9e10550_0, 0, 1;
    %set/v v0x9e103b0_0, 0, 1;
    %set/v v0x9e10418_0, 0, 1;
    %jmp T_3.4;
T_3.3 ;
    %load/v 8, v0x9e10220_0, 1;
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
    %set/v v0x9e10698_0, 9, 2;
    %set/v v0x9e10620_0, 0, 1;
    %set/v v0x9e10550_0, 1, 1;
    %set/v v0x9e103b0_0, 1, 1;
    %set/v v0x9e10418_0, 0, 1;
    %jmp T_3.4;
T_3.4 ;
    %jmp T_3;
    .thread T_3, $push;
    .scope S_0x9e10be0;
T_4 ;
    %wait E_0x9de7780;
    %load/v 8, v0x9e11048_0, 1;
    %jmp/0xz  T_4.0, 8;
    %load/v 8, v0x9e10f00_0, 32;
    %pad 40, 0, 32;
    %load/v 72, v0x9e10f90_0, 32;
    %pad 104, 0, 32;
    %mul 8, 72, 64;
    %set/v v0x9e11150_0, 8, 64;
    %ix/load 0, 1, 0;
    %assign/v0 v0x9e110a0_0, 0, 1;
    %ix/load 0, 1, 0;
    %assign/v0 v0x9e110f8_0, 0, 0;
    %jmp T_4.1;
T_4.0 ;
    %load/v 8, v0x9e10e90_0, 1;
    %jmp/0xz  T_4.2, 8;
    %ix/load 0, 1, 0;
    %assign/v0 v0x9e110f8_0, 0, 1;
    %ix/load 0, 1, 0;
    %assign/v0 v0x9e110a0_0, 0, 0;
T_4.2 ;
T_4.1 ;
    %jmp T_4;
    .thread T_4;
    .scope S_0x9e10808;
T_5 ;
    %wait E_0x9de7780;
    %load/v 8, v0x9e10978_0, 1;
    %jmp/0xz  T_5.0, 8;
    %set/v v0x9e10a00_0, 0, 1;
    %jmp T_5.1;
T_5.0 ;
    %load/v 8, v0x9e10a70_0, 64;
    %load/v 72, v0x9e10b00_0, 64;
    %cmp/u 8, 72, 64;
    %jmp/0xz  T_5.2, 4;
    %set/v v0x9e10a00_0, 1, 1;
    %jmp T_5.3;
T_5.2 ;
    %set/v v0x9e10a00_0, 0, 1;
T_5.3 ;
T_5.1 ;
    %jmp T_5;
    .thread T_5;
    .scope S_0x9deec00;
T_6 ;
    %load/v 8, v0x9e113d0_0, 1;
    %jmp/0xz  T_6.0, 8;
    %delay 5, 0;
    %set/v v0x9e113d0_0, 0, 1;
    %jmp T_6.1;
T_6.0 ;
    %delay 5, 0;
    %set/v v0x9e113d0_0, 1, 1;
T_6.1 ;
    %jmp T_6;
    .thread T_6;
    .scope S_0x9deec00;
T_7 ;
    %wait E_0x9deecf0;
    %delay 50, 0;
    %set/v v0x9e112d8_0, 1, 1;
    %jmp T_7;
    .thread T_7;
    .scope S_0x9deec00;
T_8 ;
    %wait E_0x9deecc8;
    %delay 50, 0;
    %set/v v0x9e112d8_0, 0, 1;
    %jmp T_8;
    .thread T_8;
    .scope S_0x9deec00;
T_9 ;
    %wait E_0x9ddc018;
    %vpi_func 2 120 "$random", 8, 32 {0 0};
    %movi 40, 10, 32;
    %mod 8, 40, 32;
    %ix/load 0, 32, 0;
    %assign/v0 v0x9e11260_0, 0, 8;
    %vpi_func 2 121 "$random", 8, 32 {0 0};
    %movi 40, 10, 32;
    %mod 8, 40, 32;
    %ix/load 0, 32, 0;
    %assign/v0 v0x9e11378_0, 0, 8;
    %delay 500, 0;
    %ix/load 0, 1, 0;
    %assign/v0 v0x9e116e0_0, 0, 1;
    %delay 100, 0;
    %ix/load 0, 1, 0;
    %assign/v0 v0x9e116e0_0, 0, 0;
    %jmp T_9;
    .thread T_9;
    .scope S_0x9deec00;
T_10 ;
    %vpi_call 2 129 "$dumpfile", "av_Waves.vcd" {0 0};
    %vpi_call 2 130 "$dumpvars" {0 0};
    %delay 5, 0;
    %set/v v0x9e113d0_0, 0, 1;
    %set/v v0x9e11548_0, 0, 1;
    %set/v v0x9e112d8_0, 0, 1;
    %set/v v0x9e116e0_0, 0, 1;
    %movi 8, 1, 32;
    %set/v v0x9e11260_0, 8, 32;
    %movi 8, 1, 32;
    %set/v v0x9e11378_0, 8, 32;
    %delay 15, 0;
    %set/v v0x9e11548_0, 1, 1;
    %delay 80, 0;
    %set/v v0x9e11548_0, 0, 1;
    %delay 5000, 0;
    %vpi_call 2 143 "$finish" {0 0};
    %end;
    .thread T_10;
# The file index is used to find the file name in the following table.
:file_names 5;
    "N/A";
    "<interactive>";
    "automatic_verificator.v";
    "./Mult_Controller.v";
    "./Collaterals.v";
