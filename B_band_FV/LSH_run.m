% % % % % This code based on input with a single row vector
% The input have size (1,K) K is the kwindow if in WTA hashing; orelse has
% size(1,Q) where Q is the size of projection metric in IOM

band=1; %ignore this, just let it be 1;

polynomial_length_k=10 ;%polynomial size (k)

tokenthreshold=8000;%expansion token range 

parameter_N=30000; %range of input element (N)

num_chaff=15; %independent vault size (v)

u=1312;           %polynomial last value (main key) can random choose from range [1, coefrange]

coefrange=256;   %polynomial coeff range 

largeprime=45000;  % the largest prime number within 45000 (q)                                    

u
        



%random generate k-1 polynomial coefficient
coef_vector=randperm(coefrange,(polynomial_length_k-1));

% we take sample of feature from maxout folder 
% Expansion function (bijection modulo transformation F(x))
file1=strcat('Samples\',num2str(2), '_',num2str(4),'.mat');% user #2,4th sample

 load(file1); 
 A = maxout_code;
 randommat=randi(tokenthreshold,size(A,2)); randommat=randommat(1,:);

 A=A.*randommat;

 A=mod(A,parameter_N);


%start bind key
[ y, coutput,primen,realpoint ] = bindkey( A,num_chaff,parameter_N,u,largeprime,band,coef_vector);


%save output into file
Filename=[num2str(2), '_',num2str(4),'.mat']; 
Filename2=[num2str(2), '_',num2str(4),'.mat']; 

jpegToSaveFileName = fullfile('genuine_chaff_set\', Filename);
save(jpegToSaveFileName,'coutput');% use path if you want to save to same directory
% dlmwrite(jpegToSaveFileName, coutput);

jpegToSaveFileName = fullfile('genuine_chaff_correspondence\', Filename2);% use path if you want to save to same directory
% dlmwrite(jpegToSaveFileName, y);
save(jpegToSaveFileName,'y');% use path if you want to save to same directory










%test key relase with user #2, 5th sample.
file2=strcat('Samples\',num2str(2), '_',num2str(5),'.mat');

%Gone through same bijection function F(x)
%be sure use back same randommat for query; 
load(file2);
B = maxout_code;

B=B.*randommat;B=mod(B,parameter_N);


%Open vault record previously stored
fileoutput=strcat('genuine_chaff_set\',num2str(2), '_',num2str(4),'.mat');
load(fileoutput);

filey=strcat('genuine_chaff_correspondence\',num2str(2), '_',num2str(4),'.mat');
load(filey);


%key release mechanism
[regen_u,match_point,matched_point_get ] = keyrelease( B,coutput,y,num_chaff,primen,polynomial_length_k,band );

regen_u



% Try to check either regen_u=u, if same, means u is inside the polynomial



