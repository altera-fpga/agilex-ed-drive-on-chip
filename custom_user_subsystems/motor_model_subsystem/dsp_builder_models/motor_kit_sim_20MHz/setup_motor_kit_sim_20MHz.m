%##################################################################################
% Copyright (C) 2025 Altera Corporation
%
% This software and the related documents are Altera copyrighted materials, and
% your use of them is governed by the express license under which they were
% provided to you ("License"). Unless the License provides otherwise, you may
% not use, modify, copy, publish, distribute, disclose or transmit this software
% or the related documents without Altera's prior written permission.
%
% This software and the related documents are provided as is, with no express
% or implied warranties, other than those that are expressly stated in the License.
%##################################################################################


ModelName_str       =   bdroot; % bdroot returns name of Simulink model
ThisFileName_str    =   ['setup_' ModelName_str '.m'];

disp(' ');
disp(['Running ' ThisFileName_str ':']);
disp(' ');
disp('===========================================================' );
disp('DSP Builder 16-bit fixed point model of ');
disp('Permanent Magnet Synchronous Motor (PMSM)' );
disp('===========================================================' );

ClockFrequency =            20;                                 %[MHz]
FoldingFactor =             500;
DSPBASampleTime =           0.05e-6;                            % 50 ns

%DSP Builder
wordLength =                16;
DataType =                  sfix(16);
DataTypeU =                 ufix(16);               %Data Type for 16 bit unsigned value
DataTypeFraction =          ufix(16);               %Data Type for Fraction_ND block
DataType_dxdt =             sfix(20);               %Data Type for di/dt & dq/dt signals (rate of change of current)
DataTypeTorque =            sfix(20);               %Data Type for Torque signal
DataType_dq =               sfix(27);               %Data type for alpha-beta to dq transform output
DataTypeSpeed =             sfix(27);               %Data Type for the Speed Signal
DataTypeCurrentDerivative = sfix(28);               %Data Type for internal derivative of current signal
DataType_Current =          sfix(28);               %Data Type for internal current signal (i_A_k)
DataTypeAcceleration =      sfix(32);               %Data Type for the Acceleration Signal
DataTypeSpeedRate =         sfix(32);               %Data Type for the Rate of change of speed Signal
DataTypeDis =               sfix(32);               %Data Type for the Distance Signal
DataTypeTheta_OneTurn =     ufix(37);               %Data Type for the Angle Signal

constScale =                    2^-13;
constScaleGain =                2^-15;
constScaleVoltage =             2^-6;
constScaleVoltage_range =       2^0;
constScaleCurrent =             2^-9;
constScaleCurrent_range =       2^0;
constScaleTorque =              2^-14;
constScaleCurrentDerivative =   2^-2;
constScaleTrig =                2^-14;              %Scaling Used for Sin/Cos functions
constScaleSinCos =              2^-13;              %Scaling Used for Sin/Cos functions
constScale_dq =                 2^-16;              %Scaling used for dq signals within park transform
constScale_Current =            2^-20;              %Scaling used for internal current
constScaleAcceleration =        2^-4;               %Scaling used for Acceleration
constScaleSpeed  =              2^-24;              %Scaling used for Speed
constScaleSpeedRate =           2^-20;              %Scaling used for Rate of change of speed
constScaleDis =                 2^-38;              %Scaling used Distance
constScaleTheta_OneTurn =       2^-37;              %Scaling used for Angle
constScaleFraction =            2^-16;              %Scaling used for Fraction_ND block


%%Motor ParametersTamagawa TS4747N3200E600 PMSM%%
Rphase_ohm =                    0.68/3;             %Phase Resistance [Ohm]
Lphase_H =                      3.0e-3/3;           %Phase Inductance [H]
invLphase_1_H =                 1/Lphase_H;         %inverse Phase Inductance [1/H]
Ke_Vs_rad =                     0.033;              %Back-EMF constant kE based on peak phase values [Vs/rad]
Kt_Nm_A =                       0.033;              %Motor Torque constant kT based on peak phase values [Nm/A]
PolePairs_int =                 2;                  %Number of pole pairs 0.5*n poles [integer]
J_kgm2 =                        0.165e-4;           %Mechanical Inertia [kgm^2]
invJ_1_kgm2 =                   1/J_kgm2;           %inverse Mechanical Inertia [1/(kgm^2)]
%note: we set kE = kT from dtasheet kT = 0.07 N*m/A so it is already a peak value

%Avalon Bus Width
DSPBA_avalon_bus_width = 32;
DSPBA_avalon_bytes_per_word = DSPBA_avalon_bus_width / 8;

%Define Avalon MM register address map (Word addresses)
%constant values below are in bytes, and then converted to words.
Busy =               0 / DSPBA_avalon_bytes_per_word;
Start =              4 / DSPBA_avalon_bytes_per_word;
Ready =             12 / DSPBA_avalon_bytes_per_word;
SampleTime_cfg =    64 / DSPBA_avalon_bytes_per_word;
Rphase_cfg =        68 / DSPBA_avalon_bytes_per_word;
inv_Lphase_cfg =    72 / DSPBA_avalon_bytes_per_word;
PolePairs_cfg =     76 / DSPBA_avalon_bytes_per_word;
Ke_cfg =            80 / DSPBA_avalon_bytes_per_word;
Kt_cfg =            84 / DSPBA_avalon_bytes_per_word;
inv_J_cfg =         88 / DSPBA_avalon_bytes_per_word;

Vabc_range_cfg =    124 / DSPBA_avalon_bytes_per_word;
Va =                128 / DSPBA_avalon_bytes_per_word;
Vb =                132 / DSPBA_avalon_bytes_per_word;
Vc =                136 / DSPBA_avalon_bytes_per_word;

LoadT =             140 / DSPBA_avalon_bytes_per_word;
reset =             144 / DSPBA_avalon_bytes_per_word;
DC_link_V =         148 / DSPBA_avalon_bytes_per_word;
DC_link_range_cfg = 152 / DSPBA_avalon_bytes_per_word;
Iabc_range_cfg  =   188 / DSPBA_avalon_bytes_per_word;
ia =                192 / DSPBA_avalon_bytes_per_word;
ib =                196 / DSPBA_avalon_bytes_per_word;
ic =                200 / DSPBA_avalon_bytes_per_word;
                    
dTheta_dt =         216 / DSPBA_avalon_bytes_per_word;
ThetaMech =         220 / DSPBA_avalon_bytes_per_word;

%--------------------------------------------------------------------------
%Writing a .stm file which can be read by the Bus Stimulus Reader block
%thus allowing us to write to the Memory Mapped Interface
%--------------------------------------------------------------------------
disp('===========================================================' );
disp('Generating Bus Stimulus (.stm) file');
disp('===========================================================' );

filename = 'motor_kit_sim_20MHz_Autogen.stm';
fileID = fopen(filename,'w');

fprintf(fileID, '#  STM generated by gen_bus_stimulus.m\n');
fprintf(fileID, '#  MemSpace    Address WriteData   WE RE   ExpReadData Mask\n');


%Parameter Initialisation
fprintf(fileID, '#  Reset assert \n');
bus_stim_32bit_write(fileID, 36, 1);
fprintf(fileID, '#  Reset de-assert \n');
bus_stim_32bit_write(fileID, 36, 0);
fprintf(fileID, '# Start calc. in reset \n');
bus_stim_32bit_write(fileID, Start, 0);

fprintf(fileID, '#  SampleTime_CFG=500e-6(dec)\n');
bus_stim_32bit_write(fileID, SampleTime_cfg, 27488);
fprintf(fileID, '#  R_Phase=0.2267(dec)\n');
bus_stim_32bit_write(fileID, Rphase_cfg, 14877);
fprintf(fileID, '#  Inv_Lphase=1000(dec)\n');
bus_stim_32bit_write(fileID, inv_Lphase_cfg, 64000);
fprintf(fileID, '#  PolePairs=2(dec)\n');
bus_stim_32bit_write(fileID, PolePairs_cfg, 32768);
fprintf(fileID, '#  Ke_cfg=0.033(dec)\n');
bus_stim_32bit_write(fileID, Ke_cfg, 2163);
fprintf(fileID, '#  Kt_cfg=0.033(dec)\n');
bus_stim_32bit_write(fileID, Kt_cfg, 2163);
fprintf(fileID, '#  Inv_J_cfg=60606(dec)\n');
bus_stim_32bit_write(fileID, inv_J_cfg, 60606);
fprintf(fileID, '#  LoadT=0(dec)\n');
bus_stim_32bit_write(fileID, LoadT, 0);
fprintf(fileID, '#  DC link =19661(dec)\n');
bus_stim_32bit_write(fileID, DC_link_V, 19661);

% %Voltage inputs
 fprintf(fileID, '#  V_a=2.5(dec)\n');
 bus_stim_32bit_write(fileID, Va, 1280);
 fprintf(fileID, '#  V_b=2.5(dec)\n');
 bus_stim_32bit_write(fileID, Vb, 1280);
 fprintf(fileID, '#  V_c=-5(dec)\n');
 bus_stim_32bit_write(fileID, Vc, 0xF600);

% %Start processing - with reset off
% %0x024 -> 36(dec) means the reset idk why but it don't like the word
fprintf(fileID, '# Start calc. in reset \n');

% for i=1:1000
    bus_stim_32bit_write(fileID, Start, 0);
    bus_stim_32bit_write(fileID, Start, 1);
% end
fprintf(fileID, '#  Reset de-assert \n');
bus_stim_32bit_write(fileID, 36, 0);

%Idle
bus_stim_idle_cycle(fileID);
fclose(fileID);

function bus_stim_32bit_write(fid, ad, dt)
    fprintf(fid, '1 %2X %4X 1 0        0 FFFFFFFF \n', ad, dt);
end

function bus_stim_32bit_read(fid, ad, expected)
    fprintf(fid, '1 %2X    0 0 1 %8X FFFFFFFF \n', ad, expected);
end

function bus_stim_idle_cycle(fid)
    fprintf(fid, '1  0    0 0 0        0        0\n');
end
