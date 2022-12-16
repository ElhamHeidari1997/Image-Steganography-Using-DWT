close all;clear all;clc;
stego_image = imread('stego_image.bmp');
height = size(stego_image, 1); 
width = size(stego_image, 2); 
chars = input('How many characters your massage has: ');
message_length = chars * 8;

s=100;
counter = 1;
for row=1:8:height
    for col=1:8:width
        
         block=stego_image(row:row+7,col:col+7);
        [LL,LH,HL,HH]= dwt2(block,'haar');
        
        if (counter <= message_length)
        decision=LL(2,2) - s* floor (LL(2,2)/s);
        if (decision> s/2)
            extracted_bits(counter, 1)=1;
        else 
            extracted_bits(counter, 1)=0;
        end
        counter = counter + 1; 
        end
    end
end
binValues = [ 128 64 32 16 8 4 2 1 ]; 
  
 
binMatrix = reshape(extracted_bits, 8, (message_length/8)); 
  
 
textString = char(binValues*binMatrix);  

disp(textString);