function ret = normalwrapper(mu,sig)

    ret = normrnd(mu,sig);

    while (ret < 0)
        ret = normrnd(mu,sig);
    end
end