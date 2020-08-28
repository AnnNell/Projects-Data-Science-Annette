



clc;
clear all;
close all;
%%

%  x=double(rgb2gray(imread('uav_trucks1__256.jpg')));
  x=double(rgb2gray(imread('air12.jpg')));

%%
[m,n]=size(x);

bk_size=4;
border_size=1;
%%
j=inf*ones(255,1);
histogram=double(histc(x(:),0:255))/size(x(:),1);

%%
seg_label_arr(1:m,1:n)=0;
seg_label_arr1(1:m,1:n)=0;

%%
label=1;Labelcount=0;
val=0;out=seg_label_arr;


for a=border_size:bk_size: m
     for b=border_size: bk_size: n

        z1=x(a:a+bk_size-1,b:b+bk_size-1);
        first=0;val=val+1;
      for k=a:bk_size:m
          if(k>a)
              
              for h=1:bk_size:n
               
              if(seg_label_arr(k,h)==0)
                    temp_img=x(k:k+bk_size-1,h:h+bk_size-1);
                    tmp(k,h)=sum(sum(abs((temp_img)-(z1))));
                  
                    if(tmp(k,h)<(402))
                        if(first==0)
                            label=label+1;
                            first=1;
                         end
                        
                      seg_label_arr(k:k+bk_size-1,h:h+bk_size-1)=label;                        
                    end
              end
           end
          else
           for h=b:bk_size:n
               
              if(seg_label_arr(k,h)==0)
                    temp_img=x(k:k+bk_size-1,h:h+bk_size-1);
                    tmp(k,h)=sum(sum(abs((temp_img)-(z1))));
                  
                    if(tmp(k,h)<402)
                        if(first==0)
                            label=label+1;
                            first=1;
                         end
                        
                      seg_label_arr(k:k+bk_size-1,h:h+bk_size-1)=label ;                        
                    end
              end
           end   
        end
      end                       

    end
end


figure;imagesc(seg_label_arr1);

label_arr1=zeros(1,(m/bk_size)*(n/bk_size));

for i=1:1: m/bk_size
     for j=1: 1:n/bk_size
         
label_arr1(((i-1)*64)+j)=seg_label_arr(((i-1)*bk_size)+1,((j-1)*bk_size)+1);
     end
end

label_arr=label_arr1(:)';
no_pixels_per_label=zeros(1,label+1);
for i=1:1: length(label_arr)
   
         no_pixels_per_label(label_arr(i)+1)= no_pixels_per_label(label_arr(i)+1)+1;
end

for i=1:1:m
  for j=1:1: n 
      % this works only for uav truck image
     if((no_pixels_per_label(seg_label_arr(i,j))>15 || no_pixels_per_label(seg_label_arr(i,j))<12)) 
       binary(i,j)      = 0;
       seg_imag(i,j)    = 0;
     else
       seg_imag(i,j)   = seg_label_arr(i,j);
      binary(i,j)       =1; 
     end
end
end
%for writng purpose only
seg_label_arr1=(seg_label_arr*5);

imwrite(uint8(seg_label_arr1),'seg_imag.png','png')
% Applied projection algorithm to find the size of objects in vhdl.

%  cnt=0;
%  for i=1: n
%       for j=1: m
%                 if(binary(j,i)==1) 
%                    cnt=cnt+1;
%                 end 
%       end
%       vertical_proj(i)= cnt;
%        cnt=0;
%      
%  end 
%  cnt=1;
%  for i=1:1: n
%       if(i==1)
%           if(vertical_proj(i)>0)
%                   v_array(cnt)= 1; 
%                   cnt          =  cnt+1;
%           end  
%       else
%           if(vertical_proj(i)==0 && vertical_proj(i-1)>0 )
%                    v_array(cnt)  =    i-1 ;  
%                    cnt          =       cnt+1;
%                    
%           elseif(vertical_proj(i)>0 && vertical_proj(i-1)==0 )         
%                    v_array(cnt)  =    i ;  
%                    cnt          =       cnt+1;    
%                    
%                    
%           end  
%       end
% end



figure(1)
subplot(2,2,1); imshow(uint8(x));
title('Original Image');
subplot(2,2,2);imshow(seg_label_arr1,[]);
title('segmented Image');
subplot(2,2,3);imshow(binary);
title('segmented Image');

subplot(2,2,4);imshow(uint8(x));
title('output Image');


