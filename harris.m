%Algoritmo detector de esquinas harris

im = imread('jefe.png')%Imagen a utilizar
[m,n]=size(im);
U=zeros(size(im));
S=zeros(size(im));
H=ones(3,3)/9;%Matriz de coeficientes para el fito Pre-suavizador
id=double(im);

IF = imfilter(id,H);

    Hx=[-0.5 0 0.5];%Se generan matrices de coeficientes para calcular el gradiente E X y Y
    Hy=[-0.5;0;0.5];%Columnas
    ix=imfilter(IF,Hx);
    iy=imfilter(IF,Hy);
   HE11=ix.*ix;
   HE22=iy.*iy;
   HE12=ix.*iy;
%Se crea la matriz del filtro gauss

Hg=[0 1 2 1 0; 1 3 5 3 1; 2 5 9 5 2; 1 3 5 3 1; 0 1 2 1 0];
Hg=Hg*(1/57)

A=imfilter(HE11,Hg);
B=imfilter(HE22,Hg);
C=imfilter(HE12,Hg);

alfa=0.04;
Rp=A+B
Rp1=Rp.*Rp;
%Valor de la esquina
Q=((A.*B)-(C.*C)-(alfa*Rp1));
th=1000;
U=Q>th
pixel=10;

for r=1:m
    for c=1:n
        if(U(r,c))
            %Se define el limite izquierdo de la vecindad
            I1=[r-pixel 1];
            I2=[r+pixel m];%Derecho
            I3=[c-pixel 1];%Sup
            I4=[c+pixel n];%Inf
            datxi=max(I1);
            datxs=min(I2);
            datyi=max(I3);
            datys=min(I4);

            Bloc=Q(datxi:1:datxs,datyi:1:datys);
            MaxB=max(max(Bloc));%Vector max vecindario
            if(Q(r,c)==MaxB)
                S(r,c)=1;
            end

        end
    end
end

figure(1)
imshow(im)
hold on

for r=1:m
    for c=1:n
        if(S(r,c))
            plot(c,r,'+')
        end
    end
end
