DFwidth=340;
DFheight=395;


%eden
include("planimeter.eden");
include("input.eden");


## place pointer in centre and reset counter
~drawPanel_mousePos=[0.5,0];
~Reset_mouse_1 = [1,4,0,14, 9];
~Reset_mouse_1 = [1,5,256,15, 8];

## determined empirically
calibrate=-0.006389;

## demo interaction
procmacro doTrace {
~drawPanel_mousePos = [0.0, 0.11];
~drawPanel_mousePos = [0.003125, 0.11];
~Reset_mouse_1 = [1,4,0,14, 9];
~Reset_mouse_1 = [1,5,256,15, 8];
~drawPanel_mousePos = [0.00625, 0.105];
~drawPanel_mousePos = [0.0125, 0.115];
~drawPanel_mousePos = [0.015625, 0.12];
~drawPanel_mousePos = [0.021875, 0.125];
~drawPanel_mousePos = [0.028125, 0.13];
~drawPanel_mousePos = [0.040625, 0.145];
~drawPanel_mousePos = [0.046875, 0.15];
~drawPanel_mousePos = [0.053125, 0.155];
~drawPanel_mousePos = [0.059375, 0.16];
~drawPanel_mousePos = [0.0625, 0.16];
~drawPanel_mousePos = [0.0625, 0.165];
~drawPanel_mousePos = [0.065625, 0.165];
~drawPanel_mousePos = [0.06875, 0.17];
~drawPanel_mousePos = [0.075, 0.185];
~drawPanel_mousePos = [0.078125, 0.185];
~drawPanel_mousePos = [0.078125, 0.19];
~drawPanel_mousePos = [0.08125, 0.19];
~drawPanel_mousePos = [0.084375, 0.2];
~drawPanel_mousePos = [0.0875, 0.2];
~drawPanel_mousePos = [0.090625, 0.205];
~drawPanel_mousePos = [0.096875, 0.21];
~drawPanel_mousePos = [0.10625, 0.22];
~drawPanel_mousePos = [0.10625, 0.225];
~drawPanel_mousePos = [0.109375, 0.23];
~drawPanel_mousePos = [0.109375, 0.235];
~drawPanel_mousePos = [0.1125, 0.235];
~drawPanel_mousePos = [0.115625, 0.25];
~drawPanel_mousePos = [0.11875, 0.25];
~drawPanel_mousePos = [0.11875, 0.255];
~drawPanel_mousePos = [0.121875, 0.26];
~drawPanel_mousePos = [0.121875, 0.265];
~drawPanel_mousePos = [0.125, 0.27];
~drawPanel_mousePos = [0.13125, 0.28];
~drawPanel_mousePos = [0.13125, 0.285];
~drawPanel_mousePos = [0.134375, 0.295];
~drawPanel_mousePos = [0.1375, 0.295];
~drawPanel_mousePos = [0.146875, 0.31];
~drawPanel_mousePos = [0.15625, 0.32];
~drawPanel_mousePos = [0.16875, 0.33];
~drawPanel_mousePos = [0.171875, 0.335];
~drawPanel_mousePos = [0.171875, 0.34];
~drawPanel_mousePos = [0.175, 0.345];
~drawPanel_mousePos = [0.184375, 0.36];
~drawPanel_mousePos = [0.184375, 0.365];
~drawPanel_mousePos = [0.1875, 0.365];
~drawPanel_mousePos = [0.1875, 0.37];
~drawPanel_mousePos = [0.19375, 0.385];
~drawPanel_mousePos = [0.196875, 0.39];
~drawPanel_mousePos = [0.203125, 0.41];
~drawPanel_mousePos = [0.20625, 0.43];
~drawPanel_mousePos = [0.209375, 0.43];
~drawPanel_mousePos = [0.209375, 0.435];
~drawPanel_mousePos = [0.2125, 0.45];
~drawPanel_mousePos = [0.215625, 0.455];
~drawPanel_mousePos = [0.23125, 0.48];
~drawPanel_mousePos = [0.2375, 0.49];
~drawPanel_mousePos = [0.25, 0.51];
~drawPanel_mousePos = [0.253125, 0.53];
~drawPanel_mousePos = [0.259375, 0.54];
~drawPanel_mousePos = [0.2625, 0.555];
~drawPanel_mousePos = [0.26875, 0.575];
~drawPanel_mousePos = [0.26875, 0.585];
~drawPanel_mousePos = [0.271875, 0.595];
~drawPanel_mousePos = [0.275, 0.62];
~drawPanel_mousePos = [0.278125, 0.625];
~drawPanel_mousePos = [0.278125, 0.635];
~drawPanel_mousePos = [0.284375, 0.66];
~drawPanel_mousePos = [0.2875, 0.665];
~drawPanel_mousePos = [0.290625, 0.68];
~drawPanel_mousePos = [0.296875, 0.69];
~drawPanel_mousePos = [0.296875, 0.695];
~drawPanel_mousePos = [0.3, 0.695];
~drawPanel_mousePos = [0.3, 0.7];
~drawPanel_mousePos = [0.309375, 0.72];
~drawPanel_mousePos = [0.3125, 0.725];
~drawPanel_mousePos = [0.31875, 0.73];
~drawPanel_mousePos = [0.321875, 0.73];
~drawPanel_mousePos = [0.33125, 0.725];
~drawPanel_mousePos = [0.334375, 0.72];
~drawPanel_mousePos = [0.3375, 0.72];
~drawPanel_mousePos = [0.340625, 0.7];
~drawPanel_mousePos = [0.34375, 0.69];
~drawPanel_mousePos = [0.35, 0.655];
~drawPanel_mousePos = [0.35, 0.65];
~drawPanel_mousePos = [0.35, 0.645];
~drawPanel_mousePos = [0.353125, 0.625];
~drawPanel_mousePos = [0.353125, 0.61];
~drawPanel_mousePos = [0.35625, 0.585];
~drawPanel_mousePos = [0.35625, 0.58];
~drawPanel_mousePos = [0.3625, 0.55];
~drawPanel_mousePos = [0.365625, 0.535];
~drawPanel_mousePos = [0.365625, 0.53];
~drawPanel_mousePos = [0.365625, 0.525];
~drawPanel_mousePos = [0.365625, 0.52];
~drawPanel_mousePos = [0.365625, 0.515];
~drawPanel_mousePos = [0.36875, 0.515];
~drawPanel_mousePos = [0.36875, 0.51];
~drawPanel_mousePos = [0.371875, 0.475];
~drawPanel_mousePos = [0.371875, 0.47];
~drawPanel_mousePos = [0.375, 0.445];
~drawPanel_mousePos = [0.375, 0.44];
~drawPanel_mousePos = [0.378125, 0.44];
~drawPanel_mousePos = [0.38125, 0.44];
~drawPanel_mousePos = [0.384375, 0.44];
~drawPanel_mousePos = [0.3875, 0.44];
~drawPanel_mousePos = [0.39375, 0.42];
~drawPanel_mousePos = [0.4, 0.42];
~drawPanel_mousePos = [0.40625, 0.415];
~drawPanel_mousePos = [0.409375, 0.42];
~drawPanel_mousePos = [0.415625, 0.435];
~drawPanel_mousePos = [0.41875, 0.435];
~drawPanel_mousePos = [0.428125, 0.45];
~drawPanel_mousePos = [0.434375, 0.45];
~drawPanel_mousePos = [0.44375, 0.465];
~drawPanel_mousePos = [0.446875, 0.47];
~drawPanel_mousePos = [0.453125, 0.485];
~drawPanel_mousePos = [0.453125, 0.49];
~drawPanel_mousePos = [0.45625, 0.51];
~drawPanel_mousePos = [0.45625, 0.515];
~drawPanel_mousePos = [0.4625, 0.535];
~drawPanel_mousePos = [0.465625, 0.54];
~drawPanel_mousePos = [0.465625, 0.56];
~drawPanel_mousePos = [0.46875, 0.565];
~drawPanel_mousePos = [0.471875, 0.585];
~drawPanel_mousePos = [0.471875, 0.595];
~drawPanel_mousePos = [0.478125, 0.6];
~drawPanel_mousePos = [0.48125, 0.645];
~drawPanel_mousePos = [0.484375, 0.67];
~drawPanel_mousePos = [0.4875, 0.675];
~drawPanel_mousePos = [0.490625, 0.68];
~drawPanel_mousePos = [0.496875, 0.705];
~drawPanel_mousePos = [0.496875, 0.71];
~drawPanel_mousePos = [0.503125, 0.73];
~drawPanel_mousePos = [0.503125, 0.735];
~drawPanel_mousePos = [0.509375, 0.755];
~drawPanel_mousePos = [0.509375, 0.76];
~drawPanel_mousePos = [0.5125, 0.78];
~drawPanel_mousePos = [0.51875, 0.795];
~drawPanel_mousePos = [0.53125, 0.82];
~drawPanel_mousePos = [0.53125, 0.83];
~drawPanel_mousePos = [0.534375, 0.835];
~drawPanel_mousePos = [0.534375, 0.84];
~drawPanel_mousePos = [0.534375, 0.845];
~drawPanel_mousePos = [0.5375, 0.855];
~drawPanel_mousePos = [0.5375, 0.86];
~drawPanel_mousePos = [0.540625, 0.86];
~drawPanel_mousePos = [0.54375, 0.86];
~drawPanel_mousePos = [0.546875, 0.865];
~drawPanel_mousePos = [0.55, 0.865];
~drawPanel_mousePos = [0.55625, 0.865];
~drawPanel_mousePos = [0.5625, 0.86];
~drawPanel_mousePos = [0.5625, 0.855];
~drawPanel_mousePos = [0.565625, 0.855];
~drawPanel_mousePos = [0.571875, 0.84];
~drawPanel_mousePos = [0.571875, 0.835];
~drawPanel_mousePos = [0.58125, 0.815];
~drawPanel_mousePos = [0.58125, 0.81];
~drawPanel_mousePos = [0.584375, 0.81];
~drawPanel_mousePos = [0.59375, 0.79];
~drawPanel_mousePos = [0.59375, 0.785];
~drawPanel_mousePos = [0.596875, 0.785];
~drawPanel_mousePos = [0.596875, 0.78];
~drawPanel_mousePos = [0.603125, 0.75];
~drawPanel_mousePos = [0.60625, 0.74];
~drawPanel_mousePos = [0.60625, 0.735];
~drawPanel_mousePos = [0.609375, 0.73];
~drawPanel_mousePos = [0.609375, 0.725];
~drawPanel_mousePos = [0.6125, 0.72];
~drawPanel_mousePos = [0.6125, 0.715];
~drawPanel_mousePos = [0.621875, 0.67];
~drawPanel_mousePos = [0.621875, 0.665];
~drawPanel_mousePos = [0.621875, 0.66];
~drawPanel_mousePos = [0.625, 0.655];
~drawPanel_mousePos = [0.6375, 0.615];
~drawPanel_mousePos = [0.640625, 0.605];
~drawPanel_mousePos = [0.65625, 0.57];
~drawPanel_mousePos = [0.659375, 0.565];
~drawPanel_mousePos = [0.659375, 0.56];
~drawPanel_mousePos = [0.659375, 0.555];
~drawPanel_mousePos = [0.659375, 0.55];
~drawPanel_mousePos = [0.665625, 0.51];
~drawPanel_mousePos = [0.66875, 0.495];
~drawPanel_mousePos = [0.671875, 0.49];
~drawPanel_mousePos = [0.678125, 0.445];
~drawPanel_mousePos = [0.678125, 0.44];
~drawPanel_mousePos = [0.68125, 0.44];
~drawPanel_mousePos = [0.690625, 0.405];
~drawPanel_mousePos = [0.690625, 0.4];
~drawPanel_mousePos = [0.7, 0.38];
~drawPanel_mousePos = [0.703125, 0.375];
~drawPanel_mousePos = [0.703125, 0.37];
~drawPanel_mousePos = [0.715625, 0.34];
~drawPanel_mousePos = [0.71875, 0.335];
~drawPanel_mousePos = [0.728125, 0.3];
~drawPanel_mousePos = [0.728125, 0.29];
~drawPanel_mousePos = [0.73125, 0.285];
~drawPanel_mousePos = [0.74375, 0.245];
~drawPanel_mousePos = [0.74375, 0.24];
~drawPanel_mousePos = [0.746875, 0.24];
~drawPanel_mousePos = [0.75625, 0.215];
~drawPanel_mousePos = [0.75625, 0.21];
~drawPanel_mousePos = [0.7625, 0.21];
~drawPanel_mousePos = [0.78125, 0.195];
~drawPanel_mousePos = [0.784375, 0.195];
~drawPanel_mousePos = [0.7875, 0.195];
~drawPanel_mousePos = [0.790625, 0.19];
~drawPanel_mousePos = [0.79375, 0.19];
~drawPanel_mousePos = [0.796875, 0.19];
~drawPanel_mousePos = [0.8, 0.185];
~drawPanel_mousePos = [0.803125, 0.185];
~drawPanel_mousePos = [0.80625, 0.18];
~drawPanel_mousePos = [0.825, 0.175];
~drawPanel_mousePos = [0.83125, 0.175];
~drawPanel_mousePos = [0.85, 0.165];
~drawPanel_mousePos = [0.853125, 0.16];
~drawPanel_mousePos = [0.85625, 0.16];
~drawPanel_mousePos = [0.859375, 0.16];
~drawPanel_mousePos = [0.878125, 0.165];
~drawPanel_mousePos = [0.878125, 0.17];
~drawPanel_mousePos = [0.88125, 0.17];
~drawPanel_mousePos = [0.89375, 0.195];
~drawPanel_mousePos = [0.896875, 0.2];
~drawPanel_mousePos = [0.9, 0.2];
~drawPanel_mousePos = [0.903125, 0.2];
~drawPanel_mousePos = [0.903125, 0.205];
~drawPanel_mousePos = [0.90625, 0.21];
~drawPanel_mousePos = [0.915625, 0.24];
~drawPanel_mousePos = [0.91875, 0.25];
~drawPanel_mousePos = [0.91875, 0.255];
~drawPanel_mousePos = [0.928125, 0.3];
~drawPanel_mousePos = [0.934375, 0.33];
~drawPanel_mousePos = [0.934375, 0.335];
~drawPanel_mousePos = [0.940625, 0.34];
~drawPanel_mousePos = [0.953125, 0.375];
~drawPanel_mousePos = [0.953125, 0.385];
~drawPanel_mousePos = [0.95625, 0.39];
~drawPanel_mousePos = [0.959375, 0.42];
~drawPanel_mousePos = [0.965625, 0.43];
~drawPanel_mousePos = [0.975, 0.44];
~drawPanel_mousePos = [0.975, 0.445];
~drawPanel_mousePos = [0.98125, 0.445];
~drawPanel_mousePos = [0.984375, 0.445];
~drawPanel_mousePos = [0.9875, 0.445];
~drawPanel_mousePos = [0.99375, 0.435];
~drawPanel_mousePos = [0.99375, 0.43];
~drawPanel_mousePos = [0.99375, 0.405];
~drawPanel_mousePos = [0.99375, 0.395];
~drawPanel_mousePos = [0.990625, 0.36];
~drawPanel_mousePos = [0.990625, 0.355];
~drawPanel_mousePos = [0.990625, 0.35];
~drawPanel_mousePos = [0.990625, 0.345];
~drawPanel_mousePos = [0.99375, 0.3];
~drawPanel_mousePos = [0.99375, 0.29];
~drawPanel_mousePos = [0.99375, 0.28];
~drawPanel_mousePos = [0.99375, 0.275];
~drawPanel_mousePos = [0.99375, 0.27];
~drawPanel_mousePos = [0.996875, 0.255];
~drawPanel_mousePos = [0.996875, 0.205];
~drawPanel_mousePos = [0.996875, 0.2];
~drawPanel_mousePos = [0.996875, 0.175];
~drawPanel_mousePos = [0.99375, 0.155];
~drawPanel_mousePos = [0.99375, 0.15];
~drawPanel_mousePos = [0.99375, 0.145];
~drawPanel_mousePos = [0.99375, 0.14];
~drawPanel_mousePos = [0.99375, 0.135];
~drawPanel_mousePos = [0.99375, 0.13];
~drawPanel_mousePos = [0.99375, 0.125];
~drawPanel_mousePos = [0.99375, 0.115];
~drawPanel_mousePos = [0.9875, 0.07];
~drawPanel_mousePos = [0.9875, 0.055];
~drawPanel_mousePos = [0.9875, 0.05];
~drawPanel_mousePos = [0.9875, 0.045];
~drawPanel_mousePos = [0.990625, 0.045];
~drawPanel_mousePos = [0.990625, 0.04];
~drawPanel_mousePos = [0.990625, 0.035];
~drawPanel_mousePos = [0.99375, 0.03];
~drawPanel_mousePos = [0.996875, -0.0];
~drawPanel_mousePos = [0.99375, 0.01];
~drawPanel_mousePos = [0.99375, 0.015];
~drawPanel_mousePos = [0.99375, 0.02];
~drawPanel_mousePos = [0.0, 0.005];
~drawPanel_mousePos = [0.0, 0.015];
~drawPanel_mousePos = [0.0, 0.005];
~drawPanel_mousePos = [0.0, -0.0];
~drawPanel_mousePos = [0.0, 0.035];
~drawPanel_mousePos = [0.0, 0.045];
~drawPanel_mousePos = [0.0, 0.05];
~drawPanel_mousePos = [0.0, 0.055];
~drawPanel_mousePos = [0.0, 0.08];
~drawPanel_mousePos = [0.0, 0.1];
~drawPanel_mousePos = [0.0, 0.105];
}