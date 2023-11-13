clear all
load('feature.mat')
load('index.mat')


%nter = encoding time step
n=20; k=10; nter=1;


emb_idx1=1:2:12000;
emb_idx2=2:2:12000;

lfwfeature1=lfwfeature(emb_idx1,:);
lfwfeature2=lfwfeature(emb_idx2,:);


score=[]; score2=[];score31=[];score32=[];
for i=1:6000
    i
    u=lfwfeature1(i,:);
    v=lfwfeature2(i,:);

    ii=1;

% entanglement take place here
% we apply encoding directly on u and v for each encoding time step
    
    while ii<=nter


    % Encoding for u
        [fu1,filter1]=Encoding(u',n,k);
        fu1=fu1';
        u=fu1;


    % Encoding for v   
        fu2=filter1*(v');
        fu2=fu2';
        v=fu2;

        ii=ii+1;



    end

    u = u/norm(u);  % Normalize the vector
    v = v/norm(v);  % Normalize the vector


    fu1=sign(u);
    fu2=sign(v);



    dis2=acos(dot(u, v))/pi;  % compute theta (angle)
    dis31=sum((v-u).^2);      % compute squared Euc distance for anti correlation
    dis32=sum((v+u).^2);      % compute squared Euc distance for anti correlation
    dis=sum(fu1~=fu2)/length(fu1); % compute hamming distance

    score=[score;dis];
    score2=[score2;dis2];
    score31=[score31;dis31];
    score32=[score32;dis32];
end

% seperate genuine(intraclass) and imposter (interclass)  distance distribution
gen=score31(find(index==1));
imp=score31(find(index==0));


% uncomment this if want to show plot for squre Euc distance
gen2=score32(find(index==1));
imp2=score32(find(index==0));

plot_score_distributions(gen,imp, gen2,imp2)






















function [yfil,frmat]=Encoding(x,n,t)
k=length(x);

rmat=randn(n,k);
% rmat=orth(rmat);
y=rmat*x;
absy=abs(y);
[sorted_data, sortedindex ]= sort(absy, 'descend');
topindex=(sortedindex(1:t));
frmat=rmat(topindex,:);
yfil=y(topindex);

end








