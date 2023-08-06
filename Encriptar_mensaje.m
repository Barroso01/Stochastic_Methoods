clear all 
clc

msg= char("Todos sacan cien");
key=round(rand(1,8*numel(msg)));

%Vamos a acondicionar el mensaje
DoubleMsg=double(msg);
BinMsgC=dec2bin(DoubleMsg,8);
BinMsgVec=reshape(BinMsgC',1,[])-'0';

%Encriptada
Enc=mod(BinMsgVec+key,2);

%Decriptar el mensaje
Dec=mod(Enc+key,2);

CharRead= char(reshape(Dec'+"0",8,[])');
char(bin2dec(CharRead))'