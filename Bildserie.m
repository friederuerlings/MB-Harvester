%% Bildserie

Subplot_Groese = [5 4];

%% Subplot

figure('Name', 'Bildserie')

Bilder = round(linspace(1, 68, Subplot_Groese(1)*Subplot_Groese(2)));


for o = 1:1:length(Bilder)

    n = Bilder(o);

    subplot(Subplot_Groese(1),Subplot_Groese(2),o)

    plotData.subsVec = [q_1(t) q_2(t) q_3(t) q_4(t) q_5(t) q_6(t) q_7(t) q_8(t) q_9(t) t];

    % define XYZ for harvester plot
    CSPlotHarvTemp = subs(coordSys.sumKS, plotData.subsVec, [plotData.y(n,1:9) plotData.time(n)]);
    CSPlotTreeTemp = subs(coordSys.sumBS, plotData.subsVec, [plotData.y(n,1:9) plotData.time(n)]);
    plot3(CSPlotHarvTemp(1,:),CSPlotHarvTemp(3,:),CSPlotHarvTemp(2,:),'-o');
    hold on
    plot3(CSPlotTreeTemp(1,:),CSPlotTreeTemp(3,:),CSPlotTreeTemp(2,:),'-o');


    % axis([-15 15 -15 15 0 15])
    axis([-5 15 -15 15 0 12]) % ISO View
    % axis([5 8 -2.5 2.5 0 3]) % Close Up

    view(27, 15) % ISO Ansicht
    % view(19, 24) % Close Up 1
    % view(80, 17) % Close Up 2

    %     set(gcf,'DefaultTextFontSize', 12, 'position',[50,50,1000,500]) % Big
    % Frame
    set(gcf,'DefaultTextFontSize', 12, 'position',[50,50,1000,900]) % Small Frame
    grid

end