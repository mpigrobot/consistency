%% Plot the dynamic motion
    h = initFigure(xTrue, muPost, sensorPos);
    if makeVideo
        videoObj           = VideoWriter('bearingrangeekfdemo.avi');
        videoObj.FrameRate = 5;
        videoObj.Quality   = 50;
        open(videoObj);
    end
    for i = 1 : step
            [xEnd,yEnd] = pol2cart(zTrue(1, i),zTrue(2, i));
            set(h.trueObs, 'xdata', [sensorPos(1),xEnd + sensorPos(1)],...
                           'ydata', [sensorPos(2),yEnd + sensorPos(2)]);
            set(h.truePat, 'xdata', xTrue(1, 1:i), 'ydata', xTrue(2, 1:i));
            set(h.predPat, 'xdata', muPred(1, 1:i), 'ydata', muPred(2, 1:i));
            set(h.postPat, 'xdata', muPost(1, 1:i), 'ydata', muPost(2, 1:i));
            %%
            trueRobBody     = compound(xTrue(:,i), rob);
            set(h.trueRob, 'xdata', trueRobBody(1, :), ...
                'ydata', trueRobBody(2, :));
            %
            predRobBody     = compound(muPred(:,i),rob);
            set(h.predRob, 'xdata', predRobBody(1, :), ...
                'ydata', predRobBody(2, :));
            %
            postRobBody     = compound(muPost(:,i),rob);
            set(h.postRob, 'xdata', postRobBody(1, :), ...
                'ydata', postRobBody(2, :));
            drawnow;
            if mod(i, 5) == 0 && makeVideo
                writeVideo(videoObj, getframe(h.all));
            end
    end
    if makeVideo
        close(videoObj);
    end