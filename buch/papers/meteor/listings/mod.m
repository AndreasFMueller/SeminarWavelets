tmp1 = abs(cfs);
t1 = size(tmp1,2);
tmp1 = tmp1';
maxv = max(tmp1);
maxvArray = maxv(ones(1,t1),:);
tmp1 = 240*(tmp1./maxvArray);
tmp2 = 1+fix(tmp1);
tmp2 = tmp2';
