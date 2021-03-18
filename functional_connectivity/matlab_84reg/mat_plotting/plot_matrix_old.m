function plot_matrix_old(matrix, figure_name, color_range, voxels, vet_dist, vet_label, vet_color, vet_cum)
% Authors: Edoardo Paolini, Walter Endrizzi
% 18/04/2020
% Questa funzione serve a plottare le matrici ottenute dalle varie misure
% di connettività, e prende in input la matrice in questione, il nome della
% figure e il range della colorbar, quindi dei valori che si vogliono
% vedere nel plot.

% Definiamo la figure
figure('NumberTitle', 'off', 'Name', figure_name);
% Definiamo gli assi
ax1 = axes;
ax2 = axes;
ax3 = axes;
% Plottiamo la matrice di connettività con gli assi secondo ax1
imagesc(ax1, matrix);
% Nascondiamo gli altri due assi
ax1.Visible = 'off';
ax2.Visible = 'off';
ax3.Visible = 'off';
% Diamo a ogni oggetto asse la propria colormap
colormap(ax1,'jet'); % unica che influenza la matrice
colormap(ax2, vet_color);
colormap(ax3, vet_color);
% Creiamo le tre colorbar in base alle colormap
colorbar(ax1, 'eastoutside');
caxis(ax1,color_range);
c2 = colorbar(ax2, 'westoutside', 'Ticks',vet_dist, 'TickLabels',vet_label,...
    'Direction', 'reverse'); 
caxis(ax2, [1 voxels+1]);
c3 = colorbar(ax3, 'southoutside', 'Ticks',vet_cum+1, 'TickLabels',vet_cum); 
caxis(ax3, [1 voxels+1]);
% Creiamo i label per le due colorbar dei network 
c2.Label.String = 'Network Funzionali';
c3.Label.String = 'Network Funzionali';
% Otteniamo l'oggetto posizione di ax1
P = get(ax1,'Position');
P2 = P;
P2(1) = P2(1)+0.014;
P3 = P;
P3(2) = P3(2)+0.03;
% Otteniamo i valori limiti per gli assi X e Y
XLIM = get(ax1,'XLim');
YLIM = get(ax1,'YLim');
% Otteniamo le proporzioni degli assi del boxplot
PA = get(ax1,'PlotBoxAspectRatio');
% Settiamo la posizione dei vari assi e quindi delle colorbar
set(ax1,'Position',P,'XLim',XLIM,'YLim',YLIM,'PlotBoxAspectRatio',PA);
set(ax2,'Position',P2,'XLim',XLIM,'YLim',YLIM,'PlotBoxAspectRatio',PA);
set(ax3,'Position',P3,'XLim',XLIM,'YLim',YLIM,'PlotBoxAspectRatio',PA);
% Definiamo la posizione e la dimensione della figura con il seguente vettore
% dove: [left offset, bottom offset, width, height]
set(gcf, 'Position',  [50, 50, 800, 700]);


% Per vedere i nomi delle regioni cerebrali
%{
set(gca, 'XTick', vec_voxels, 'XTickLabel', brain_sort, 'YTick', vec_voxels, 'YTickLabel', brain_sort)
xtickangle(45);
%}

