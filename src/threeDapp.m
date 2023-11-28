% Build app 
app = uifigure();
app.Position(3) = 1400;
app.Position(4) = 900;
app.Color = '#FFFFFF';
global p t
global MAX_X MAX_Y MAX_Z
global xRotPi yRotPi zRotPi
global xTranslation yTranslation zTranslation
global xScale yScale zScale


% Declare constants for UI elements
Padding = 10;
Field_Height = 20;
Field_Width = 130;
Spacer = Field_Height + Padding
TopLeftY = app.Position(4) - Spacer;
Mini_Field_Width = 40;
HeaderX = 10
XComponent = 30
CamLabelMainPos = 10 
CamLabelMainWidth = 50
CamXLabelPos = 10;

CamXLabelNamePos = 10 + (Mini_Field_Width/2);
CamYInputPos = Padding + Field_Height
CamYLabelPos = CamYInputPos - Field_Height
XLabel = XComponent + Field_Width + 10

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
buildAnimationButton.Position = [HeaderX TopLeftY Field_Width Field_Height];
buildAnimationButton.Text = '▶︎ obj build animation';

%Camera/Perspective mode Dropdown%
perspDd = uidropdown(app,"Items",["orthographic","perspective"]);
perspDd.Position = [HeaderX (TopLeftY-(Spacer)) Field_Width Field_Height];
perspDd_Label = uilabel(app);
perspDd_Label.Text = 'Perspective Mode';
perspDd_Label.Position = [XLabel (TopLeftY-(Spacer)) Field_Width Field_Height];

%Line style Dropdown%
LineDd = uidropdown(app,"Items",["none","-"]);
LineDd.Position = [HeaderX (TopLeftY-(2*Spacer)) Field_Width Field_Height];
LineDd_Label = uilabel(app);
LineDd_Label.Text = 'Line Style';
LineDd_Label.Position = [XLabel (TopLeftY-(2*Spacer)) Field_Width Field_Height];

%% Transforms
SliderSamples = 1000;
xRotPi = 0;
yRotPi = 0;
zRotPi = 0;
xTranslation = 0;
yTranslation = 0;
zTranslation = 0;
xScale = 1;
yScale = 1;
zScale = 1;

TransformsLable = uilabel(app);
TransformsLable.Text = 'Transformations:';
TransformsLable.Position = [HeaderX (TopLeftY-(4*Spacer)) Field_Width Field_Height];
TransformsSpacerStart = TopLeftY-(4*Spacer) - Spacer
TransformsSpacer = Spacer + Field_Height
%% Rotation Transforms
% x rotation slider
xRotSlider = uislider(app);
xRotSlider.Position = [XComponent (TransformsSpacerStart) Field_Width Field_Height];
xRotSlider.Limits = [0 SliderSamples];
xRotSlider.Value = 0;
xRotSlider.MajorTicks = [0 1/2 1 3/2 2] * SliderSamples;
xRotSlider.MajorTickLabels = (xRotSlider.MajorTicks/SliderSamples)*2 + "π";
xRotSlider.MinorTicks = [1/4 3/4 5/4 7/4] * SliderSamples;
xRotSlider_Label = uilabel(app);
xRotSlider_Label.Text = 'x Axis Rotation';
xRotSlider_Label.Position = [XLabel (TransformsSpacerStart) Field_Width Field_Height];
% y rotation slider
yRotSlider = uislider(app);
yRotSlider.Position = [XComponent (TransformsSpacerStart-TransformsSpacer) Field_Width Field_Height];
yRotSlider.Limits = [0 SliderSamples];
yRotSlider.Value = 0;
yRotSlider.MajorTicks = [0 1/2 1 3/2 2] * SliderSamples;
yRotSlider.MajorTickLabels = (yRotSlider.MajorTicks/SliderSamples)*2 + "π";
yRotSlider.MinorTicks = [1/4 3/4 5/4 7/4] * SliderSamples;
yRotSlider_Label = uilabel(app);
yRotSlider_Label.Text = 'y Axis Rotation';
yRotSlider_Label.Position = [XLabel (TransformsSpacerStart-TransformsSpacer) Field_Width Field_Height];
% z rotation slider
zRotSlider = uislider(app);
zRotSlider.Position = [XComponent (TransformsSpacerStart-2*TransformsSpacer) Field_Width Field_Height];
zRotSlider.Limits = [0 SliderSamples];
zRotSlider.Value = 0;
zRotSlider.MajorTicks = [0 1/2 1 3/2 2] * SliderSamples;
zRotSlider.MajorTickLabels = (zRotSlider.MajorTicks/SliderSamples)*2 + "π";
zRotSlider.MinorTicks = [1/4 3/4 5/4 7/4] * SliderSamples;
zRotSlider_Label = uilabel(app);
zRotSlider_Label.Text = 'z Axis Rotation';
zRotSlider_Label.Position = [XLabel (TransformsSpacerStart-2*TransformsSpacer) Field_Width Field_Height];

%% Translation Transforms
% x translation slider
xTranslSlider = uislider(app);
xTranslSlider.Position = [XComponent (TransformsSpacerStart-3*TransformsSpacer) Field_Width Field_Height];
xTranslSlider.Limits = [-3 3];
xTranslSlider.Value = 0;
xTranslSlider_Label = uilabel(app);
xTranslSlider_Label.Position = [XLabel (TransformsSpacerStart-3*TransformsSpacer) Field_Width Field_Height];
xTranslSlider_Label.Text = 'x Axis Translation';
% y translation slider
yTranslSlider = uislider(app);
yTranslSlider.Position = [XComponent (TransformsSpacerStart-4*TransformsSpacer) Field_Width Field_Height];
yTranslSlider.Limits = [-3 3];
yTranslSlider.Value = 0;
yTranslSlider_Label = uilabel(app);
yTranslSlider_Label.Position = [XLabel (TransformsSpacerStart-4*TransformsSpacer) Field_Width Field_Height];
yTranslSlider_Label.Text = 'y Axis Translation';
% z translation slider
zTranslSlider = uislider(app);
zTranslSlider.Position = [XComponent (TransformsSpacerStart-5*TransformsSpacer) Field_Width Field_Height];
zTranslSlider.Limits = [-3 3];
zTranslSlider.Value = 0;
zTranslSlider_Label = uilabel(app);
zTranslSlider_Label.Position = [XLabel (TransformsSpacerStart-5*TransformsSpacer) Field_Width Field_Height];
zTranslSlider_Label.Text = 'z Axis Translation';

%% Scale Transforms
% x scale slider
xScaleSlider = uislider(app);
xScaleSlider.Position = [XComponent (TransformsSpacerStart-6*TransformsSpacer) Field_Width Field_Height];
xScaleSlider.Limits = [0.001 2];
xScaleSlider.Value = 1;
xScaleSlider_Label = uilabel(app);
xScaleSlider_Label.Position = [XLabel (TransformsSpacerStart-6*TransformsSpacer) Field_Width Field_Height];
xScaleSlider_Label.Text = 'x Axis Scale';
% y scale slider
yScaleSlider = uislider(app);
yScaleSlider.Position = [XComponent (TransformsSpacerStart-7*TransformsSpacer) Field_Width Field_Height];
yScaleSlider.Limits = [0.001 2];
yScaleSlider.Value = 1;
yScaleSlider_Label = uilabel(app);
yScaleSlider_Label.Position = [XLabel (TransformsSpacerStart-7*TransformsSpacer) Field_Width Field_Height];
yScaleSlider_Label.Text = 'y Axis Scale';
% z scale slider
zScaleSlider = uislider(app);
zScaleSlider.Position = [XComponent (TransformsSpacerStart-8*TransformsSpacer) Field_Width Field_Height];
zScaleSlider.Limits = [0.001 2];
zScaleSlider.Value = 1;
zScaleSlider_Label = uilabel(app);
zScaleSlider_Label.Position = [XLabel (TransformsSpacerStart-8*TransformsSpacer) Field_Width Field_Height];
zScaleSlider_Label.Text = 'z Axis Scale';

%% Materials
MaterialsLable = uilabel(app);
MaterialsLable.Text = 'Materials/Color:';
MaterialsLable.Position = [HeaderX (TransformsSpacerStart-9*TransformsSpacer-Spacer) Field_Width Field_Height];
MaterialSpacerStart = (TransformsSpacerStart-9*TransformsSpacer-2*Spacer)
% Material Dropdown
MaterialDd = uidropdown(app,"Items",["shiny","metal","dull"]);
MaterialDd.Position = [XComponent MaterialSpacerStart Field_Width Field_Height];
MaterialDd_Label = uilabel(app);
MaterialDd_Label.Text = 'Material';
MaterialDd_Label.Position = [XLabel MaterialSpacerStart Field_Width Field_Height];
% Face Color Dropdown
ColorMapDd = uidropdown(app,"Items",["parula",'turbo','hsv','hot','cool','spring','summer','autumn','winter','gray','bone','copper','pink','sky','abyss','jet','lines','colorcube','prism','flag']);
ColorMapDd.Position = [XComponent (MaterialSpacerStart-Spacer) Field_Width Field_Height];
ColorMapDd_Label = uilabel(app);
ColorMapDd_Label.Text = 'Colormap';
ColorMapDd_Label.Position = [XLabel (MaterialSpacerStart-Spacer) Field_Width Field_Height];

%Camera Position  Label
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



%% Render the geometry
[verts, faces, cindex] = teapotGeometry;
AC_DIMENSION = max(max(sqrt(sum(verts.^2,2))));

MAX_X = max(max(sqrt(sum(verts(1, :).^2,2))));
MAX_Y = max(max(sqrt(sum(verts(2, :).^2,2))));  
MAX_Z = max(max(sqrt(sum(verts(3, :).^2,2))));

% AC_DIMENSION = max(MAX_X, MAX_Y, (MAX_Z/2))
p = patch(Axes_3D, 'Faces',faces,'Vertices',verts,'FaceVertexCData',cindex,'FaceColor','flat','LineStyle','none');
t = hgtransform('Parent', Axes_3D);
set(p,'Parent',t)
applyTransforms();
% M = makehgtform('translate',[-(MAX_X/2) -(MAX_Y/2) -(MAX_Z/2)])
% CenterTranslation = makehgtform('translate',[0 0 -(MAX_Z/2)])
% set(t,'Matrix',CenterTranslation);
% drawnow;

material(Axes_3D, 'shiny');
l1 = light(Axes_3D, 'Position',[5 0 2],'Style','infinite','Color','white')
l2 = light(Axes_3D, 'Position',[0 0 -3],'Style','infinite','Color','white')
l3 = light(Axes_3D, 'Position',[-5 0 3],'Style','infinite','Color','white')
% l1 = light(Axes_3D, 'Position',[5 0 2],'Style','infinite','Color','r')
% l2 = light(Axes_3D, 'Position',[0 0 -3],'Style','infinite','Color','g')
% l3 = light(Axes_3D, 'Position',[-5 0 3],'Style','infinite','Color','b')
lighting gouraud

euler_hgt(1)  = hgtransform('Parent', Axes_3D, 'tag', 'OriginAxes');
euler_hgt(2)  = hgtransform( Axes_3D, 'Parent', euler_hgt(1), 'tag', 'roll_disc');
euler_hgt(3)  = hgtransform( Axes_3D, 'Parent', euler_hgt(1), 'tag', 'pitch_disc');
euler_hgt(4)  = hgtransform( Axes_3D, 'Parent', euler_hgt(1), 'tag', 'heading_disc');
euler_hgt(5)  = hgtransform( Axes_3D, 'Parent', euler_hgt(2), 'tag', 'roll_line');
euler_hgt(6)  = hgtransform( Axes_3D, 'Parent', euler_hgt(3), 'tag', 'pitch_line');
euler_hgt(7)  = hgtransform( Axes_3D, 'Parent', euler_hgt(4), 'tag', 'heading_line');
Draw_Guide_Lines(Axes_3D, AC_DIMENSION, euler_hgt)


%Setting callback functions to update cam positions for each input field%
buildAnimationButton.ButtonPushedFcn = @(src,event) Obj_Build_Animation(Axes_3D);
perspDd.ValueChangedFcn = @(perspDd,event) Toggle_Perspective(perspDd, Axes_3D)
LineDd.ValueChangedFcn = @(LineDd,event) Toggle_Wireframe(LineDd)

xRotSlider.ValueChangingFcn = @(src,event) updateXRot(src,event,t,SliderSamples);
yRotSlider.ValueChangingFcn = @(src,event) updateYRot(src,event,t,SliderSamples);
zRotSlider.ValueChangingFcn = @(src,event) updateZRot(src,event,t,SliderSamples);

xTranslSlider.ValueChangingFcn = @(src,event) updateXTrans(src,event,t);
yTranslSlider.ValueChangingFcn = @(src,event) updateYTrans(src,event,t);
zTranslSlider.ValueChangingFcn = @(src,event) updateZTrans(src,event,t);

xScaleSlider.ValueChangingFcn = @(src,event) updateXScale(src,event,t);
yScaleSlider.ValueChangingFcn = @(src,event) updateYScale(src,event,t);
zScaleSlider.ValueChangingFcn = @(src,event) updateZScale(src,event,t);

MaterialDd.ValueChangedFcn = @(src,event) updateMaterial(Axes_3D, MaterialDd)
ColorMapDd.ValueChangedFcn = @(src,event) updateColormap(Axes_3D, ColorMapDd)

x1.ValueChangedFcn = @(x1,event) Set_Cam_XPos(x1, Axes_3D)
y1.ValueChangedFcn = @(y1,event) Set_Cam_YPos(y1, Axes_3D)
z1.ValueChangedFcn = @(z1,event) Set_Cam_ZPos(z1, Axes_3D)

% Allow object to be rotated
h = rotate3d(Axes_3D);
h.Enable = 'on';
% add callback to update Camera Position
h.ActionPostCallback = @(src,event) Set_Cam_Pos(x1, y1, z1, Axes_3D);

% Apply all Transforms
function [] = applyTransforms();
global t MAX_Z;
global xRotPi yRotPi zRotPi;
global xTranslation yTranslation zTranslation
global xScale yScale zScale
Rxyz = makehgtform( ...
    'xrotate', xRotPi, ...
    'yrotate', yRotPi, ...
    'zrotate', zRotPi, ...
    'translate',[xTranslation yTranslation zTranslation-(MAX_Z/2)], ...
    'scale', [xScale, yScale, zScale]);
set(t,'Matrix',Rxyz);
drawnow;
end

%X-axis rotate transform
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

%X-axis Translate transform
function [] = updateXTrans(src,event,t);
global xTranslation
xTranslation = event.Value
%applyTransforms(t);
applyTransforms();
end

%Y-axis Translate transform
function [] = updateYTrans(src,event,t);
global yTranslation
yTranslation = event.Value
%applyTransforms(t);
applyTransforms();
end

%Z-axis Translate transform
function [] = updateZTrans(src,event,t);
global zTranslation
zTranslation = event.Value
%applyTransforms(t);
applyTransforms();
end

%X-axis Scale transform
function [] = updateXScale(src,event,t);
global xScale
xScale = event.Value
%applyTransforms(t);
applyTransforms();
end

%Y-axis Scale transform
function [] = updateYScale(src,event,t);
global yScale
yScale = event.Value
%applyTransforms(t);
applyTransforms();
end

%Z-axis Scale transform
function [] = updateZScale(src,event,t);
global zScale
zScale = event.Value
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
facecol = p.FaceColor;
animationSpeed = 20;
hold(Axes_3D, "off")
for k=1:(length(faces)/animationSpeed)
    % update the data
    % cla(Axes_3D);
    p.reset()
    p = patch(Axes_3D, 'Faces',faces(1:animationSpeed*k, :),'Vertices',verts,'FaceVertexCData',cindex,'FaceColor',facecol,'LineStyle', linestyle);
    t = hgtransform('Parent', Axes_3D);
    set(p,'Parent',t)
    applyTransforms();
    % applyTransforms();
    % p2.LineStyle = linestyle;
    % pause for 0.1 seconds
    pause(0.0000000001);
end
p.reset()
p = patch(Axes_3D, 'Faces',faces,'Vertices',verts,'FaceVertexCData',cindex,'FaceColor',facecol,'LineStyle', linestyle);
t = hgtransform('Parent', Axes_3D);
set(p,'Parent',t)
applyTransforms();
% cla(Axes_3D);
% p = patch(Axes_3D, 'Faces',faces,'Vertices',verts,'FaceVertexCData',cindex,'FaceColor','interp','LineStyle', linestyle);
% t = hgtransform('Parent', Axes_3D);
% set(p,'Parent',t)
% Draw_Guide_Lines(Axes_3D, AC_DIMENSION, euler_hgt)
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

function [] = updateFacecolor(FaceColDd)
global p
p.FaceColor = FaceColDd.Value
end

function [] = updateMaterial(Axes_3D, MaterialDd)
material(Axes_3D, MaterialDd.Value)
end

function [] = updateColormap(Axes_3D, ColorMapDd)
colormap(Axes_3D, ColorMapDd.Value)
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
plot3(Axes_3D, [S * R * D1(1, :); R * D1(1, :)],[S * R * D1(2, :); R * D1(2, :)],[S * R * D1(3, :); R * D1(3, :)], 'Color', 'b', 'tag', 'Zplane', 'Parent',euler_hgt(4));
plot3(Axes_3D, [S * R * D1(2, :); R * D1(2, :)],[S * R * D1(3, :); R * D1(3, :)],[S * R * D1(1, :); R * D1(1, :)], 'Color',[0 0.8 0], 'tag', 'Yplane', 'Parent',euler_hgt(3));
plot3(Axes_3D, [S * R * D1(3, :); R * D1(3, :)],[S * R * D1(1, :); R * D1(1, :)],[S * R * D1(2, :); R * D1(2, :)], 'Color', 'r', 'tag', 'Xplane', 'Parent',euler_hgt(2));
text(Axes_3D, R * 1.05 * D1(1, :), R * 1.05 * D1(2, :), R * 1.05 * D1(3, :), {'-x', '+y', '+x', '-y'}, 'Fontsize',9, 'color', [0 0 0], 'HorizontalAlign', 'center', 'VerticalAlign', 'middle');
text(Axes_3D, R * 1.05 * D1(3, :), R * 1.05 * D1(3, :), R * 1.05 * D1(1, :), {'-z', '', '+z', ''}, 'Fontsize',9, 'color', [0 0 0], 'HorizontalAlign', 'center', 'VerticalAlign', 'middle');
% Plot +45,+135,+180,+225,+315 Marks
S = 0.95;
phi = -pi+pi/4:2*pi/4:pi;
D1 = [sin(phi); cos(phi); zeros(size(phi))];
zPlaneMinorMarks = plot3(Axes_3D, [S*R * D1(1, :); R * D1(1, :)],[S*R * D1(2, :); R * D1(2, :)],[S*R * D1(3, :); R * D1(3, :)], 'Color', 'b', 'tag', 'Zplane', 'Parent',euler_hgt(4));


% 10 deg sub-division marks
S = 0.98;
phi = -180:10:180;
phi = phi*pi / 180;
D1 = [sin(phi); cos(phi); zeros(size(phi))];
zPlane10DegMarks = plot3(Axes_3D, [S * R * D1(1, :); R * D1(1, :)],[S * R * D1(2, :); R * D1(2, :)],[S * R * D1(3, :); R * D1(3, :)], 'Color', 'b', 'tag', 'Zplane', 'Parent', euler_hgt(4));
yPlane10DegMarks = plot3(Axes_3D, [S * R * D1(2, :); R * D1(2, :)],[S * R * D1(3, :); R * D1(3, :)],[S * R * D1(1, :); R * D1(1, :)], 'Color', [0 0.8 0], 'tag', 'Yplane', 'Parent', euler_hgt(3));
xPlane10DegMarks = plot3(Axes_3D, [S * R * D1(3, :); R * D1(3, :)],[S * R * D1(1, :); R * D1(1, :)],[S * R * D1(2, :); R * D1(2, :)], 'Color', 'r', 'tag', 'Xplane', 'Parent', euler_hgt(2));
% Guide lines
pitchGuideLine = plot3(Axes_3D, [-R, R], [ 0, 0], [0 ,0], 'g-', 'tag',   'pitch_line', 'parent', euler_hgt(6), 'color',[0 0.8 0]);
headingGuideLine = plot3(Axes_3D,  [ 0, 0], [-R, R], [0, 0], 'b-', 'tag', 'heading_line', 'parent', euler_hgt(7));
rollGuideLine = plot3(Axes_3D, [ 0, 0], [0, 0], [-R, R], 'r-', 'tag',    'roll_line', 'parent', euler_hgt(5));

end