% Build app 
app = uifigure();
app.Position(3) = 1400;
app.Position(4) = 900;
app.Color = '#FFFFFF';
global p t
global MAX_X MAX_Y MAX_Z
global xRotPi yRotPi zRotPi 

% Declare constants for UI elements
Padding = 10;
Field_Height = 20;
Field_Width = 130;
Spacer = Field_Height + Padding
TopLeftY = app.Position(4) - Spacer;
Mini_Field_Width = 40;
XComponent = 10
CamLabelMainPos = 10 
CamLabelMainWidth = 50
CamXLabelPos = 10;

CamXLabelNamePos = 10 + (Mini_Field_Width/2);
CamYInputPos = Padding + Field_Height
CamYLabelPos = CamYInputPos - Field_Height
XLabel = XComponent + Field_Width + 10

%Creating input text field for the radius%
% Radius = uieditfield(app,'numeric');
% Radius.Position = [XComponent 10 Field_Width Field_Height];
% Radius_Label = uilabel(app);
% Radius_Label.Text = 'Radius';
% Radius_Label.Position = [XLabel 10 Field_Width Field_Height];

%Creating 3D axes%
global Axes_3D 
Axes_3D = uiaxes(app);
Axes_3D.Position =   [350 100 800 800];
Axes_3D.DataAspectRatio = [1,1, 1];
Axes_3D.XAxisLocation = 'origin';
Axes_3D.YAxisLocation = 'origin';
plot3(Axes_3D,0,0,0,'Color','b');
Axes_3D.XGrid = 'on';
Axes_3D.YGrid = 'on';
Axes_3D.ZGrid = 'on';
Axes_3D.XMinorGrid = 'on';
Axes_3D.YMinorGrid = 'on';
Axes_3D.ZMinorGrid = 'on';
Axes_3D.XLabel.String = "x axis";
Axes_3D.YLabel.String = "y axis";
Axes_3D.ZLabel.String = "z axis";
Axes_3D.BackgroundColor = '#FFFFFF';
Axes_3D.Projection = "perspective";
Axes_3D.CameraTarget = [0,0,0]
% Sets axes to Origin:
% Axes_3D.XAxis.FirstCrossoverValue  = 0;
% Axes_3D.XAxis.SecondCrossoverValue = 0;
% 
% Axes_3D.YAxis.FirstCrossoverValue  = 0;
% Axes_3D.YAxis.SecondCrossoverValue = 0;
% 
% Axes_3D.ZAxis.FirstCrossoverValue  = 0;
% Axes_3D.ZAxis.SecondCrossoverValue = 0;




%Object build animation Button
buildAnimationButton = uibutton(app);
buildAnimationButton.Position = [10 TopLeftY Field_Width Field_Height];
buildAnimationButton.Text = '▶︎ obj build animation';


%Camera/Perspective mode Dropdown%
perspDd = uidropdown(app,"Items",["orthographic","perspective"]);
perspDd.Position = [XComponent (TopLeftY-(Spacer)) Field_Width Field_Height];
perspDd_Label = uilabel(app);
perspDd_Label.Text = 'Perspective Mode';
perspDd_Label.Position = [XLabel (TopLeftY-(Spacer)) Field_Width Field_Height];

%Line style Dropdown%
LineDd = uidropdown(app,"Items",["-","none"]);
LineDd.Position = [XComponent (TopLeftY-(2*Spacer)) Field_Width Field_Height];
LineDd_Label = uilabel(app);
LineDd_Label.Text = 'Line Style';
LineDd_Label.Position = [XLabel (TopLeftY-(2*Spacer)) Field_Width Field_Height];

%Rotation Transforms
RotationUpperBounds = 1000;
xRotPi = 0;
yRotPi = 0;
zRotPi = 0;

% x rotation slider
xRotSlider = uislider(app);
xRotSlider.Position = [XComponent (TopLeftY-(3*Spacer)) Field_Width Field_Height];
xRotSlider.Limits = [0 RotationUpperBounds];
xRotSlider.Value = 0;
xRotSlider.MajorTicks = [0 1/2 1 3/2 2] * RotationUpperBounds;
xRotSlider.MajorTickLabels = (xRotSlider.MajorTicks/RotationUpperBounds)*2 + "π";
xRotSlider.MinorTicks = [1/4 3/4 5/4 7/4] * RotationUpperBounds;
xRotSlider_Label = uilabel(app);
xRotSlider_Label.Text = 'x Axis Rotation';
xRotSlider_Label.Position = [XLabel (TopLeftY-(3*Spacer)) Field_Width Field_Height];
% y rotation slider
yRotSlider = uislider(app);
yRotSlider.Position = [XComponent (TopLeftY-(4*Spacer)-20) Field_Width Field_Height];
yRotSlider.Limits = [0 RotationUpperBounds];
yRotSlider.Value = 0;
yRotSlider.MajorTicks = [0 1/2 1 3/2 2] * RotationUpperBounds;
yRotSlider.MajorTickLabels = (yRotSlider.MajorTicks/RotationUpperBounds)*2 + "π";
yRotSlider.MinorTicks = [1/4 3/4 5/4 7/4] * RotationUpperBounds;
yRotSlider_Label = uilabel(app);
yRotSlider_Label.Text = 'y Axis Rotation';
yRotSlider_Label.Position = [XLabel (TopLeftY-(4*Spacer)-20) Field_Width Field_Height];

% z rotation slider
zRotSlider = uislider(app);
zRotSlider.Position = [XComponent (TopLeftY-(5*Spacer)-40) Field_Width Field_Height];
zRotSlider.Limits = [0 RotationUpperBounds];
zRotSlider.Value = 0;
zRotSlider.MajorTicks = [0 1/2 1 3/2 2] * RotationUpperBounds;
zRotSlider.MajorTickLabels = (zRotSlider.MajorTicks/RotationUpperBounds)*2 + "π";
zRotSlider.MinorTicks = [1/4 3/4 5/4 7/4] * RotationUpperBounds;
zRotSlider_Label = uilabel(app);
zRotSlider_Label.Text = 'z Axis Rotation';
zRotSlider_Label.Position = [XLabel (TopLeftY-(5*Spacer)-40) Field_Width Field_Height];


%Camera Position input Label
cam_label_main = uilabel(app);
cam_label_main.Text = 'Camera Position';
cam_label_main.Position = [XLabel+10 CamYInputPos Field_Width Field_Height];

%Creating input text field for camera x position%
x1 = uieditfield(app,'numeric');
x1.Position = [CamXLabelPos CamYInputPos Mini_Field_Width Field_Height];
x1.Value = Axes_3D.CameraPosition(1)
x1_Label = uilabel(app);
x1_Label.Text = 'x';
x1_Label.Position = [(CamXLabelNamePos) CamYLabelPos Mini_Field_Width Field_Height];
CamXLabelPos = CamXLabelPos + Mini_Field_Width + 10
CamXLabelNamePos = CamXLabelNamePos + Mini_Field_Width + 10

%Creating input text field for camera y position%
y1 = uieditfield(app,'numeric');
y1.Position = [CamXLabelPos CamYInputPos Mini_Field_Width Field_Height];
y1.Value = Axes_3D.CameraPosition(2)
y1_Label = uilabel(app);
y1_Label.Text = 'y';
y1_Label.Position = [CamXLabelNamePos CamYLabelPos Mini_Field_Width Field_Height];
CamXLabelPos = CamXLabelPos + Mini_Field_Width + 10
CamXLabelNamePos = CamXLabelNamePos + Mini_Field_Width + 10

%Creating input text field for camera z position%
z1 = uieditfield(app,'numeric');
z1.Position = [CamXLabelPos CamYInputPos Mini_Field_Width Field_Height];
z1.Value = Axes_3D.CameraPosition(3)
z1_Label = uilabel(app);
z1_Label.Text = 'z';
z1_Label.Position = [CamXLabelNamePos CamYLabelPos Mini_Field_Width Field_Height];



%Render the geometry
[verts, faces, cindex] = teapotGeometry;
AC_DIMENSION = max(max(sqrt(sum(verts.^2,2))));

MAX_X = max(max(sqrt(sum(verts(1, :).^2,2))));
MAX_Y = max(max(sqrt(sum(verts(2, :).^2,2))));  
MAX_Z = max(max(sqrt(sum(verts(3, :).^2,2))));

p = patch(Axes_3D, 'Faces',faces,'Vertices',verts,'FaceVertexCData',cindex,'FaceColor','interp');
t = hgtransform('Parent', Axes_3D);
set(p,'Parent',t)
% M = makehgtform('translate',[-(MAX_X/2) -(MAX_Y/2) -(MAX_Z/2)])
CenterTranslation = makehgtform('translate',[0 0 -(MAX_Z/2)])
set(t,'Matrix',M);
drawnow;

% colormap(Axes_3D, 'copper');
% material(Axes_3D, 'shiny');
% l = light(Axes_3D, 'Position',[-0.4 0.2 0.9],'Style','infinite')
% lighting gouraud

euler_hgt(1)  = hgtransform('Parent', Axes_3D, 'tag', 'OriginAxes');
euler_hgt(2)  = hgtransform( Axes_3D, 'Parent', euler_hgt(1), 'tag', 'roll_disc');
euler_hgt(3)  = hgtransform( Axes_3D, 'Parent', euler_hgt(1), 'tag', 'pitch_disc');
euler_hgt(4)  = hgtransform( Axes_3D, 'Parent', euler_hgt(1), 'tag', 'heading_disc');
euler_hgt(5)  = hgtransform( Axes_3D, 'Parent', euler_hgt(2), 'tag', 'roll_line');
euler_hgt(6)  = hgtransform( Axes_3D, 'Parent', euler_hgt(3), 'tag', 'pitch_line');
euler_hgt(7)  = hgtransform( Axes_3D, 'Parent', euler_hgt(4), 'tag', 'heading_line');
Draw_Guide_Lines(Axes_3D, AC_DIMENSION, euler_hgt)


%Setting callback functions to update cam positions for each input field%
x1.ValueChangedFcn = @(x1,event) Set_Cam_XPos(x1, Axes_3D)
y1.ValueChangedFcn = @(y1,event) Set_Cam_YPos(y1, Axes_3D)
z1.ValueChangedFcn = @(z1,event) Set_Cam_ZPos(z1, Axes_3D)
perspDd.ValueChangedFcn = @(perspDd,event) Toggle_Perspective(perspDd, Axes_3D)
LineDd.ValueChangedFcn = @(LineDd,event) Toggle_Wireframe(LineDd)
buildAnimationButton.ButtonPushedFcn = @(src,event) Obj_Build_Animation(Axes_3D);
xRotSlider.ValueChangingFcn = @(src,event) updateXRot(src,event,t,RotationUpperBounds);
yRotSlider.ValueChangingFcn = @(src,event) updateYRot(src,event,t,RotationUpperBounds);
zRotSlider.ValueChangingFcn = @(src,event) updateZRot(src,event,t,RotationUpperBounds);

% Allow object to be rotated
h = rotate3d(Axes_3D);
h.Enable = 'on';
% add callback to update Camera Position
h.ActionPostCallback = @(src,event) Set_Cam_Pos(x1, y1, z1, Axes_3D);

%Y-axis rotate transform
function [] = applyTransforms();
global t xRotPi yRotPi zRotPi MAX_Z;
Rxyz = makehgtform('xrotate', xRotPi,'yrotate', yRotPi,'zrotate', zRotPi, 'translate',[0 0 -(MAX_Z/2)]);
set(t,'Matrix',Rxyz);
drawnow;
end

%Y-axis rotate transform
function [] = updateXRot(src,event,t,RotationUpperBounds);
global xRotPi
xRotPi = (event.Value/RotationUpperBounds) * 2 * pi
%applyTransforms(t);
applyTransforms();
end

%Y-axis rotate transform
function [] = updateYRot(src,event,t,RotationUpperBounds);
global yRotPi
yRotPi = (event.Value/RotationUpperBounds) * 2 * pi
%applyTransforms(t);
applyTransforms();
end

%Z-axis rotate transform
function [] = updateZRot(src,event,t,RotationUpperBounds);
global zRotPi
zRotPi = (event.Value/RotationUpperBounds) * 2 * pi
%applyTransforms(t);
applyTransforms();
end

%Set Cam X,Y,Z Positions
function [] = Set_Cam_Pos(x1, y1, z1, Axes_3D)
x1.Value = Axes_3D.CameraPosition(1);
y1.Value = Axes_3D.CameraPosition(2);
z1.Value = Axes_3D.CameraPosition(3);
end

%Play obj build Animation
function [] = Obj_Build_Animation(Axes_3D)
global p t
[verts, faces, cindex] = teapotGeometry;
linestyle = p.LineStyle;
animationSpeed = 10;
for k=1:(length(faces)/animationSpeed)
    % update the data
    cla(Axes_3D);
    patch(Axes_3D, 'Faces',faces(1:animationSpeed*k, :),'Vertices',verts,'FaceVertexCData',cindex,'FaceColor','interp','LineStyle', linestyle);
    Draw_Guide_Lines(Axes_3D, AC_DIMENSION, euler_hgt)
    % p2.LineStyle = linestyle;
    % pause for 0.1 seconds
    pause(0.000000001);
end
cla(Axes_3D);
p = patch(Axes_3D, 'Faces',faces,'Vertices',verts,'FaceVertexCData',cindex,'FaceColor','interp','LineStyle', linestyle);
t = hgtransform('Parent', Axes_3D);
set(p,'Parent',t)
end

%Set Cam X Position
function [] = Set_Cam_XPos(x1, Axes_3D)
Axes_3D.CameraPosition(1) = x1.Value;
end

%Set Cam Y Position
function [] = Set_Cam_YPos(y1, Axes_3D)
Axes_3D.CameraPosition(2) = y1.Value;
end

%Set Cam Z Position
function [] = Set_Cam_ZPos(z1, Axes_3D)
Axes_3D.CameraPosition(3) = z1.Value;
end


%Switch between Orthographic and Perspective
function [] = Toggle_Perspective(perspDd, Axes_3D)
Axes_3D.Projection = perspDd.Value;
end

function [] = Toggle_Wireframe(LineDd)
global p
p.LineStyle = LineDd.Value;
end


function [] = Draw_Guide_Lines(Axes_3D, AC_DIMENSION, euler_hgt)
%% Plot Euler angles references

%Attribution: https://medium.com/geekculture/3d-animations-made-simple-with-matlab-visualizing-flight-test-data-and-simulation-results-ed399cdcc711
R = AC_DIMENSION;
% Plot outer circles
phi = (-pi:pi/36:pi)';
D1 = [sin(phi) cos(phi) zeros(size(phi))];
zPlaneCircle = plot3(Axes_3D, R * D1(:,1), R * D1(:,2), R * D1(:,3), 'Color', 'b', 'tag', 'Zplane', 'Parent', euler_hgt(4));
yPlaneCircle = plot3(Axes_3D, R * D1(:,2), R * D1(:,3), R * D1(:,1), 'Color', [0, 0.8, 0], 'tag', 'Yplane', 'Parent', euler_hgt(3));
xPlaneCircle = plot3(Axes_3D, R * D1(:,3), R * D1(:,1), R * D1(:,2), 'Color', 'r', 'tag', 'Xplane', 'Parent', euler_hgt(2));

% Plot +0,+90,+180,+270 Marks
S = 0.95;
phi = -pi+pi/2:pi/2:pi;
D1 = [sin(phi); cos(phi); zeros(size(phi))];
zPlaneMajorMarks = plot3(Axes_3D, [S * R * D1(1, :); R * D1(1, :)],[S * R * D1(2, :); R * D1(2, :)],[S * R * D1(3, :); R * D1(3, :)], 'Color', 'b', 'tag', 'Zplane', 'Parent',euler_hgt(4));
yPlaneMajorMarks = plot3(Axes_3D, [S * R * D1(2, :); R * D1(2, :)],[S * R * D1(3, :); R * D1(3, :)],[S * R * D1(1, :); R * D1(1, :)], 'Color',[0 0.8 0], 'tag', 'Yplane', 'Parent',euler_hgt(3));
xPlaneMajorMarks = plot3(Axes_3D, [S * R * D1(3, :); R * D1(3, :)],[S * R * D1(1, :); R * D1(1, :)],[S * R * D1(2, :); R * D1(2, :)], 'Color', 'r', 'tag', 'Xplane', 'Parent',euler_hgt(2));
text(R * 1.05 * D1(1, :), R * 1.05 * D1(2, :), R * 1.05 * D1(3, :), {'N', 'E', 'S', 'W'}, 'Fontsize',9, 'color', [0 0 0], 'HorizontalAlign', 'center', 'VerticalAlign', 'middle');

% Plot +45,+135,+180,+225,+315 Marks
S = 0.95;
phi = -pi+pi/4:2*pi/4:pi;
D1 = [sin(phi); cos(phi); zeros(size(phi))];
zPlaneMinorMarks = plot3(Axes_3D, [S*R * D1(1, :); R * D1(1, :)],[S*R * D1(2, :); R * D1(2, :)],[S*R * D1(3, :); R * D1(3, :)], 'Color', 'b', 'tag', 'Zplane', 'Parent',euler_hgt(4));
text(R * 1.05 * D1(1, :), R * 1.05 * D1(2, :), R * 1.05 * D1(3, :), {'NW', 'NE', 'SE', 'SW'}, 'Fontsize',8, 'color',[0 0 0], 'HorizontalAlign', 'center', 'VerticalAlign', 'middle');

% 10 deg sub-division marks
S = 0.98;
phi = -180:10:180;
phi = phi*pi / 180;
D1 = [sin(phi); cos(phi); zeros(size(phi))];
zPlane10DegMarks = plot3(Axes_3D, [S * R * D1(1, :); R * D1(1, :)],[S * R * D1(2, :); R * D1(2, :)],[S * R * D1(3, :); R * D1(3, :)], 'Color', 'b', 'tag', 'Zplane', 'Parent', euler_hgt(4));
yPlane10DegMarks = plot3(Axes_3D, [S * R * D1(2, :); R * D1(2, :)],[S * R * D1(3, :); R * D1(3, :)],[S * R * D1(1, :); R * D1(1, :)], 'Color', [0 0.8 0], 'tag', 'Yplane', 'Parent', euler_hgt(3));
xPlane10DegMarks = plot3(Axes_3D, [S * R * D1(3, :); R * D1(3, :)],[S * R * D1(1, :); R * D1(1, :)],[S * R * D1(2, :); R * D1(2, :)], 'Color', 'r', 'tag', 'Xplane', 'Parent', euler_hgt(2));
% Guide lines
headingGuideLine = plot3(Axes_3D, [-R, R], [ 0, 0], [0, 0], 'b-', 'tag', 'heading_line', 'parent', euler_hgt(7));
pitchGuideLine = plot3(Axes_3D, [-R, R], [ 0, 0], [0 ,0], 'g-', 'tag',   'pitch_line', 'parent', euler_hgt(6), 'color',[0 0.8 0]);
rollGuideLine = plot3(Axes_3D, [ 0, 0], [-R, R], [0, 0], 'r-', 'tag',    'roll_line', 'parent', euler_hgt(5));




% Initialize text handles
% FontSize    = 13;
% text_color  = [1, 0, 1];
% font_name   = 'Consolas';
% hdle_text_t                 = text(Axes_3D, 0.45 * AC_DIMENSION * 1.5, 0.55 * AC_DIMENSION * 1.5, 't=  0 sec', 'Color',text_color, 'FontSize',FontSize, 'FontName', font_name);
% hdle_text_valtitude         = text(Axes_3D, 0.45 * AC_DIMENSION * 1.5, 0.55 * AC_DIMENSION * 1.5, 0.63 * AC_DIMENSION * 1.5, '', 'Color',text_color, 'FontSize', FontSize, 'FontName', font_name);
% hdle_text_psi_deg           = text(Axes_3D, 0.45 * AC_DIMENSION * 1.5, 0.55 * AC_DIMENSION * 1.5, 0.50 * AC_DIMENSION * 1.5, '', 'Color',text_color, 'FontSize', FontSize, 'FontName', font_name);
% hdle_text_th                = text(Axes_3D, 0.45 * AC_DIMENSION * 1.5, 0.55 * AC_DIMENSION * 1.5, 0.47 * AC_DIMENSION * 1.5, '', 'Color',text_color, 'FontSize', FontSize, 'FontName', font_name);
% hdle_text_phi               = text(Axes_3D, 0.45 * AC_DIMENSION * 1.5, 0.55 * AC_DIMENSION * 1.5, 0.43 * AC_DIMENSION * 1.5, '', 'Color',text_color, 'FontSize', FontSize, 'FontName', font_name);
% hdle_text_angle_of_attack   = text(Axes_3D, 0.45 * AC_DIMENSION * 1.5, 0.55 * AC_DIMENSION * 1.5, 0.37 * AC_DIMENSION * 1.5, '', 'Color',text_color, 'FontSize', FontSize, 'FontName', font_name);
% hdle_text_angle_of_sideslip = text(Axes_3D, 0.45 * AC_DIMENSION * 1.5, 0.55 * AC_DIMENSION * 1.5, 0.34 * AC_DIMENSION * 1.5, '', 'Color',text_color, 'FontSize', FontSize, 'FontName', font_name);
% hdle_text_gam               = text(Axes_3D, 0.45 * AC_DIMENSION * 1.5, 0.55 * AC_DIMENSION * 1.5, 0.31 * AC_DIMENSION * 1.5, '', 'Color',text_color, 'FontSize', FontSize, 'FontName', font_name);
% hdle_text_nz                = text(Axes_3D, 0.45 * AC_DIMENSION * 1.5, 0.55 * AC_DIMENSION * 1.5, 0.56 * AC_DIMENSION * 1.5, '', 'Color',text_color, 'FontSize', FontSize, 'FontName', font_name);


end


%Function that gets called when any input field is changed%
function [] = Plot_Sphere(X_Field,Y_Field,Z_Field,Radius_Field,Axes_3D)

%Grab the positions.offsets from each field%
X_Position = X_Field.Value;
Y_Position = Y_Field.Value;
Z_Position = Z_Field.Value;
Radius = Radius_Field.Value;

%Creating a matrix of points for the sphere%
[X_Base,Y_Base,Z_Base] = sphere;

%Multiplying the points depending on a given radius%
X = X_Base * Radius;
Y = Y_Base * Radius;
Z = Z_Base * Radius;

%Creating a matrix of points for the circle%
Number_Of_Data_Points = 200;
theta = linspace(0,2*pi,Number_Of_Data_Points);
X_Circle = Radius*cos(theta);
Y_Circle = Radius*sin(theta);
Z_Circle = zeros(1,Number_Of_Data_Points);

%Plotting the circle%
% plot3(Axes_3D,X_Circle+X_Position,Y_Circle+Y_Position,Z_Circle+Z_Position);
% 

%Switch this line to get sphere%
% plot3(Axes_3D,X+X_Position,Y+Y_Position,Z+Z_Position,'Color',[0, 0.4470, 0.7410]);

%Switch this line to get sphere filled%
% surf(Axes_3D,X+X_Position,Y+Y_Position,Z+Z_Position);
[verts, faces, cindex] = teapotGeometry;
faces2 = faces(1:1, :);

p = patch(Axes_3D, 'Faces',faces2,'Vertices',verts,'FaceVertexCData',cindex,'FaceColor','interp')
 % for k=1:length(faces)
 %    % update the data
 %    patch(Axes_3D, 'Faces',faces(k),'Vertices',verts,'FaceVertexCData',cindex,'FaceColor','interp')
 %    % pause for 0.1 seconds
 %    pause(1);
 % end


end