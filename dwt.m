clear all ; clc; 

cover_image = imread('yellowlily.jpg'); 
cover_image=rgb2gray(cover_image);
cover_image=imresize(cover_image, [512 512]); 
height = size(cover_image, 1); 
width = size(cover_image, 2); 

message = input ('Enter your message: ' , 's');

len = length(message) * 8; 

ascii_value = uint8(message); 
bin_message = transpose(dec2bin(ascii_value, 8));
bin_message = bin_message(:); 
N = length(bin_message); 
bin_num_message=str2num(bin_message); 

output = cover_image; 
i=1;
j=1;
% power parametre
s=100;

embed_counter = 1; 
for row=1:8:height
    for col=1:8:width
        
        block=output(row:row+7,col:col+7);
        [LL,LH,HL,HH]= dwt2(block,'haar');
        
        if(embed_counter <= len)
            if (bin_num_message(embed_counter)==1)
                LL(2,2)=s*floor (LL(2,2)/s)+3*s/4;
            else
                LL(2,2)=s*floor (LL(2,2)/s)+s/4;
            end
            
            block=idwt2(LL,LH,HL,HH,'haar');
            output(row:row+7,col:col+7)=block;
            embed_counter=embed_counter+1;
        end
    end
end
subplot 121;imshow(cover_image);title('Original Image');
subplot 122; imshow(output);title('Stego image using DWT');
imwrite(output,'stego_image.bmp');
ps=psnr((output),(cover_image));
ss=ssim((output),(cover_image));