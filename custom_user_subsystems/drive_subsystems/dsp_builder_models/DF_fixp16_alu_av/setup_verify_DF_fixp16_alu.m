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

% setup_verify_DF_fixp16_alu_av.m
%
% For verification of the FoC algorithm.
% Use together with the Simulink model verify_DF_fixp16_alu_av.slx
%
% This MATLAB script sets up parameters used by the Simulink model that implements & tests 
% the field oriented control algorithm using the DSP Builder Advanced blockset.
%
% The FoldingFactor is a hint that guides the area/latency tradeoff made by DSP Builder: 
% if the FoldingFactor is large, DSP Builder will seek opportunities to time-multiplex 
% computational units in the data path. 


ModelName_str    = bdroot;     % bdroot returns name of Simulink model
ThisFileName_str = ['setup_' ModelName_str '.m'];

disp(' ');
disp(['Running ' ThisFileName_str ':']);
disp(' ');
disp('===========================================================' );
disp('Position, speed and field-oriented current control on ');
disp('Permanent Magnet Synchronous Motor (PMSM)' );
disp('===========================================================' );
    
ClockFrequency     = 100;
FoldingFactor      = 500;
DSPBASampleTime    = FoldingFactor / (ClockFrequency * 1e6);
DVSamplePeriod     = FoldingFactor;
RealDVSamplePeriod = FoldingFactor;

SampleRate         = ClockFrequency / FoldingFactor;
LatencyConstraint  = FoldingFactor;

% PwmMax represents the count after which the PWM hardware returns to a count of zero.
PwmMax = 9375;

% Fixed point types used in the FoC register interface
constOType          = sfix(32);
constScale          = 2^-10;
constwordlength     = 32;
constfractionlength = 10;

% More area-efficient fixed point types used within the algorithm (16 bits). 
constOTypeIn          = sfix(16);
constOTypeMult        = sfix(16+5);
constScaleIn          = 2^-10;
constwordlengthIn     = 16;
constfractionlengthIn = 10;

% Avalon Bus Width
DSPBA_avalon_bus_width      = 32;
DSPBA_avalon_bytes_per_word = DSPBA_avalon_bus_width / 8;

% Define Avalon MM register address map for the DSPBA FoC implementation (Word addresses)
% Constant values below are in bytes, and then converted to words.
Busy            = 0   / DSPBA_avalon_bytes_per_word;
Start           = 4   / DSPBA_avalon_bytes_per_word;
Axis            = 8   / DSPBA_avalon_bytes_per_word;
Ready           = 12  / DSPBA_avalon_bytes_per_word;
Kp_cfg          = 64  / DSPBA_avalon_bytes_per_word;
Ki_cfg          = 68  / DSPBA_avalon_bytes_per_word;
U_Sat_Limit_cfg = 72  / DSPBA_avalon_bytes_per_word;
I_Sat_Limit_cfg = 76  / DSPBA_avalon_bytes_per_word;
Iu              = 128 / DSPBA_avalon_bytes_per_word;
Iw              = 132 / DSPBA_avalon_bytes_per_word;
Torque          = 136 / DSPBA_avalon_bytes_per_word;
phi_el          = 140 / DSPBA_avalon_bytes_per_word;
reset           = 144 / DSPBA_avalon_bytes_per_word;
Valpha          = 192 / DSPBA_avalon_bytes_per_word;
Vbeta           = 196 / DSPBA_avalon_bytes_per_word;
xIq             = 216 / DSPBA_avalon_bytes_per_word;
xId             = 220 / DSPBA_avalon_bytes_per_word;
VuReg           = 224 / DSPBA_avalon_bytes_per_word;
VvReg           = 228 / DSPBA_avalon_bytes_per_word;
VwReg           = 232 / DSPBA_avalon_bytes_per_word;
AxisReg         = 240 / DSPBA_avalon_bytes_per_word;
MaximumVreg     = 248 / DSPBA_avalon_bytes_per_word;
