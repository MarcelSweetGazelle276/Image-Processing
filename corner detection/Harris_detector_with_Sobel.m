clear;
%img = imread('lena.jpg');
img = zeros(100,100)
for i = ((1/4)*100-1):((3/4)*100-1)
    for j = ((1/4)*100-1):((3/4)*100-1)
        img(i,j) = 1
    end
end
seuil = 5000
img=double(img);

if length(size(img))>2
img = rgb2gray(img);
end 

Mx = [1 0 -1; 1 0 -1; 1 0 -1]; 
My = [1 1 1; 0 0 0; -1 -1 -1]; 

Ix = filter2(Mx,img);
Iy = filter2(My,img); 

%calcul du gradient pour l'image I avec le masque de sobel

%calcul du gradient au carré
Ix2 = Ix.^2;
Iy2 = Iy.^2;
Ixy = Ix.*Iy;


height = size(img,1);
width = size(img,2);
result = zeros(height,width); 
R = zeros(height,width);
Rmax = 0; 
for i = 1:height
for j = 1:width
M = [Ix2(i,j) Ixy(i,j);Ixy(i,j) Iy2(i,j)]; 
R(i,j) = det(M)-0.01*(trace(M))^2;
if R(i,j) > Rmax
Rmax = R(i,j);
end;
end;
end;
cnt = 0;
for i = 2:height-1
for j = 2:width-1
if R(i,j) > seuil
result(i,j) = 1;
cnt = cnt+1;
end;
end;
end;
[posc, posr] = find(result == 1);
cnt ;
imshow(img);
hold on;
plot(posr,posc,'r.');