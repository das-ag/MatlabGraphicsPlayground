% Build app 
app = uifigure();
app.Position(3) = 700;
app.Color = '#FFFFFF';
global p

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
Axes_3D = uiaxes(app);
Axes_3D.Position =   [250 20 400 400];
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

%

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
p = patch(Axes_3D, 'Faces',faces,'Vertices',verts,'FaceVertexCData',cindex,'FaceColor','interp');

%Setting callback functions to update cam positions for each input field%
x1.ValueChangedFcn = @(x1,event) Set_Cam_XPos(x1, Axes_3D)
y1.ValueChangedFcn = @(y1,event) Set_Cam_YPos(y1, Axes_3D)
z1.ValueChangedFcn = @(z1,event) Set_Cam_ZPos(z1, Axes_3D)
perspDd.ValueChangedFcn = @(perspDd,event) Toggle_Perspective(perspDd, Axes_3D)
LineDd.ValueChangedFcn = @(LineDd,event) Toggle_Wireframe(LineDd)
buildAnimationButton.ButtonPushedFcn = @(src,event) Obj_Build_Animation(Axes_3D);

% Allow object to be rotated
h = rotate3d(Axes_3D);
h.Enable = 'on';
% add callback to update Camera Position
h.ActionPostCallback = @(src,event) Set_Cam_Pos(x1, y1, z1, Axes_3D);

%Set Cam X,Y,Z Positions
function [] = Set_Cam_Pos(x1, y1, z1, Axes_3D)
x1.Value = Axes_3D.CameraPosition(1);
y1.Value = Axes_3D.CameraPosition(2);
z1.Value = Axes_3D.CameraPosition(3);
end

%Play obj build Animation
function [] = Obj_Build_Animation(Axes_3D)
global p
[verts, faces, cindex] = teapotGeometry;
linestyle = p.LineStyle;
animationSpeed = 10;
for k=1:(length(faces)/animationSpeed)
    % update the data
    cla(Axes_3D);
    patch(Axes_3D, 'Faces',faces(1:animationSpeed*k, :),'Vertices',verts,'FaceVertexCData',cindex,'FaceColor','interp','LineStyle', linestyle);
    % p2.LineStyle = linestyle;
    % pause for 0.1 seconds
    pause(0.000000001);
end
cla(Axes_3D);
p = patch(Axes_3D, 'Faces',faces,'Vertices',verts,'FaceVertexCData',cindex,'FaceColor','interp','LineStyle', linestyle);
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