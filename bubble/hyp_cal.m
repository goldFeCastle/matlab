% Read Transducer Information
% Calculate Acoustic field
% file name : hyp_cal
 
if get(handles.transducer_type,'Value')==2   %piston transducer
    R=str2num(get(handles.radius,'String'))/1000;
    ele_size=str2num(get(handles.ele_size,'String'))/1000;
    Th=xdc_piston(R,ele_size);
    disp(1)
 
elseif get(handles.transducer_type,'Value')==1  % concave transducer
    R=str2num(get(handles.radius,'String'))/1000;
    ele_size=str2num(get(handles.ele_size,'String'))/1000;
    Rfocal=str2num(get(handles.focal_radius,'String'))/1000;
    Th=xdc_concave(R,Rfocal,ele_size);
    disp(2)
elseif get(handles.transducer_type,'Value')==4  %focused array transducer
    N_elements=str2num(get(handles.ele_num,'String'));
    width=str2num(get(handles.width,'String'))/1000;
    height=str2num(get(handles.height,'String'))/1000;
    kerf=str2num(get(handles.kerf,'String'))/1000;
    focus_lat=str2num(get(handles.focus_lateral,'String'))/1000;
    focus_ele=str2num(get(handles.focus_elevation,'String'))/1000;
    focus_axi=str2num(get(handles.focus_axial,'String'))/1000;
    focus=[focus_lat focus_ele focus_axi];
    Th=xdc_linear_array(N_elements, width, height, kerf, 2, 3, focus);
    disp(3)
end
center_freq=str2num(get(handles.center_freq,'String'))*1e6;
peak_int=str2num(get(handles.peak_inten,'String'));
 
 
% medium properties
acoustic_vel=str2num(get(handles.acoustic_velocity,'String'));
atten=str2num(get(handles.attenuation_coefficient,'String'));
tem_med=str2num(get(handles.temp_medium,'String'));
sampling_freq=str2num(get(handles.sampling,'String'))*1e6;
density=str2num(get(handles.density,'String'));
specific_heat=str2num(get(handles.specific_heat,'String'));
impedance=acoustic_vel*density;
 
set_field('fs',sampling_freq);
set_field('c',acoustic_vel);
set_field('att',atten*center_freq*100/1e6);
set_field('Freq_att',atten*100/1e6);
set_field('att_f0',center_freq);
set_field('use_att',1);
 
 % hyperthermia information
heating_time=str2num(get(handles.heating_time,'String'));
target_temp=str2num(get(handles.hyperthermia_temp,'String'));
 
 
% Display range
disp_lat=str2num(get(handles.range_lateral,'String'));
disp_ax2=str2num(get(handles.range_axial,'String'));
disp_ax=disp_ax2+20;
 
  
% Read Excitation Information
num_cycle=str2num(get(handles.num_cycle,'String'));
prf=str2num(get(handles.prf,'String'))*1e3;
pulse_fre=str2num(get(handles.pulse_fre,'String'))*1e6;
 
switch get(handles.excitation_pulse,'Value')
  case 3        % Delta function
    timeExcite=0;
    excitationPulse=1;  
  case 1        % Sine function
    timeExcite=0:(1/sampling_freq):(num_cycle/pulse_fre); 
    excitationPulse=100*sin(2*pi*pulse_fre*timeExcite);
  case 5        % Square function
    timeExcite=0:(1/sampling_freq):(num_cycle/pulse_fre); 
    excitationPulse=100*(.5*square(2*pi*pulse_fre*timeExcite))+.5;
end
 
tc = gauspuls('cutoff', center_freq, 0.5, -6, -40);
t = -tc:1/sampling_freq:tc;
impulseResponse =gauspuls(t, center_freq, 0.5);
xdc_impulse(Th, impulseResponse);
xdc_excitation(Th, excitationPulse);
axres=length(conv(impulseResponse,excitationPulse))*acoustic_vel/(2*sampling_freq);
 
% caclation acoustic field
resol_ax=0.5;
resol_la=0.5;

point=[0 0 0]/1000;
zvalues=(disp_ax:resol_ax:disp_ax2)/1000;
xvalues=(-disp_lat:resol_la:disp_lat)/1000;
zindex=1;
xindex=1;
inten=0;
Ppeak=0;
for z=zvalues
    for x=xvalues
        point(3)=z;
        point(1)=x;
        [y,t] = calc_hp(Th,point); 
        inten(xindex,zindex)=sum(y.*y)/(2*impedance)/sampling_freq*prf; 
        Ppeak(xindex,zindex)=max(y); 
        xindex=xindex+1;        
    end
    zindex=zindex+1;
    xindex=1;
end
inten=inten/10;
max_inten=max(max(inten));
max_peak=max(max(Ppeak));
inten=inten/max_inten*peak_int;
Ppeak=Ppeak/max_peak*100;

set_field('att',atten*center_freq*100/1e6);
set_field('Freq_att',atten*100/1e6);
set_field('att_f0',center_freq);
set_field('use_att',1);

point=[0 0 0]/1000;
zvalues=(disp_ax:resol_ax:disp_ax2)/1000;
xvalues=(-disp_lat:resol_la:disp_lat)/1000;

zindex=1;
xindex=1;

inten_att=0;
Ppeak_att=0;

ther_dose=0;
temp_dis=0;

zindex_max=0;
xindex_max=0;

max_inten_att=0;
for z=zvalues
    for x=xvalues
        point(3)=z;
        point(1)=x;
        [y,t] = calc_hp(Th,point); 
        
        inten_att(xindex,zindex)=sum(y.*y)/(2*impedance)/sampling_freq*prf; 
        Ppeak_att(xindex,zindex)=max(y); 
        
        if max_inten_att<inten_att(xindex,zindex)
            xindex_max=xindex;
            zindex_max=zindex;
            max_inten_att=inten_att(xindex,zindex);
        end
        xindex=xindex+1;        
    end
    zindex=zindex+1;
    xindex=1;
end
inten_att=inten_att/10;
inten_att=inten_att/max_inten*peak_int;
Ppeak_att=Ppeak_att/max_peak*100;
max_inten_att=max(max(inten_att));

 %Thermal dose display
if get(handles.thermal_dose_display,'Value')==1
ther_point=zeros(9,1);
ther_point(1,1)=inten_att(xindex_max-10,zindex_max-10);
ther_point(2,1)=inten_att(xindex_max,zindex_max-10);
ther_point(3,1)=inten_att(xindex_max+10,zindex_max-10);
ther_point(4,1)=inten_att(xindex_max-10,zindex_max);
ther_point(5,1)=inten_att(xindex_max,zindex_max);
ther_point(6,1)=inten_att(xindex_max+10,zindex_max);
ther_point(7,1)=inten_att(xindex_max-10,zindex_max+10);
ther_point(8,1)=inten_att(xindex_max,zindex_max+10);
ther_point(9,1)=inten_att(xindex_max+10,zindex_max+10);
    q=0.002*atten*ther_point/8.686;
    q_field=0.002*atten*inten_att/8.686;
    
end
                                   
% Temperature change display
if get(handles.temperature_display,'Value')==1
    
    if heating_time<20
    temp_graph=zeros(9,(heating_time+7)*10);
    temp_present=zeros(9,1);
    temp_dif=zeros(9,1);
    temp_present(:,:)=tem_med;
    
    for abc=1:(heating_time+7)*10
        if (abc<(heating_time+1)*10 && abc>10)
            temp_graph(:,abc)=temp_present(:,:);
            temp_dif=((q/density/specific_heat*1e6)+conduc_med*(tem_med-temp_present))*0.1;
            temp_present=temp_present+temp_dif;
        else
            temp_graph(:,abc)=temp_present;
            temp_dif=conduc_med*(tem_med-temp_present)*0.1;
            temp_present=temp_present+temp_dif;
        end
            
    end
    temp_top=65;
    figure, set(gcf,'color','w')
    subplot(3,3,1), plot(0.1:0.1:(heating_time+7),temp_graph(1,:)), 
	set(gca,'ylim',[tem_med-5 temp_top]), set(gca,'xlim', [0.1 heating_time+7])
    subplot(3,3,2), plot(0.1:0.1:(heating_time+7),temp_graph(2,:)), 
	set(gca,'ylim',[tem_med-5 temp_top]), set(gca,'xlim', [0.1 heating_time+7])
    subplot(3,3,3), plot(0.1:0.1:(heating_time+7),temp_graph(3,:)), 
	set(gca,'ylim',[tem_med-5 temp_top]), set(gca,'xlim', [0.1 heating_time+7])
    subplot(3,3,4), plot(0.1:0.1:(heating_time+7),temp_graph(4,:)), 
	set(gca,'ylim',[tem_med-5 temp_top]), set(gca,'xlim', [0.1 heating_time+7])
    subplot(3,3,5), plot(0.1:0.1:(heating_time+7),temp_graph(5,:)), 
	set(gca,'ylim',[tem_med-5 temp_top]), set(gca,'xlim', [0.1 heating_time+7])
    subplot(3,3,6), plot(0.1:0.1:(heating_time+7),temp_graph(6,:)), 
	set(gca,'ylim',[tem_med-5 temp_top]), set(gca,'xlim', [0.1 heating_time+7])
    subplot(3,3,7), plot(0.1:0.1:(heating_time+7),temp_graph(7,:)), 
	set(gca,'ylim',[tem_med-5 temp_top]), set(gca,'xlim', [0.1 heating_time+7])
    subplot(3,3,8), plot(0.1:0.1:(heating_time+7),temp_graph(8,:)), 
	set(gca,'ylim',[tem_med-5 temp_top]), set(gca,'xlim', [0.1 heating_time+7])
    subplot(3,3,9), plot(0.1:0.1:(heating_time+7),temp_graph(9,:)), 
	set(gca,'ylim',[tem_med-5 temp_top]), set(gca,'xlim', [0.1 heating_time+7])

    
    
    temp_dist=q_field;
    temp_dist(:,:)=tem_med;
    figure;
    fig_num=1;
    bs=zeros(10,2);
    for abc=1:(heating_time*10)
        temp_diff=((q_field/density/specific_heat*1e6)+conduc_med*(tem_med-temp_dist))*0.1;
        temp_dist=temp_dist+temp_diff;
        if (rem(abc,3)==0 && abc/3<10)
            subplot(3,3,fig_num)
            bb=(interp2(temp_dist,3,'cubic'))';
            mesh(bb)
            surface(xvalues*1000,zvalues*1000,(temp_dist)','Edgecolor','none');
            set(gca,'xlim',[-disp_lat disp_lat]), set(gca,'ylim', [disp_ax disp_ax2])
            bbb=size(bb);
            set(gca,'xlim',[1 bbb(2)]), set(gca, 'ylim', [1 bbb(1)])
            set(gca,'xtick',[]), set(gca,'ytick',[]), set(gca,'clim',[tem_med temp_top]), view(2)
            bs1=find(bb>55);
            bs2=find(bb>40);
            bs3=size(bb);
            bs(fig_num,1)=length(bs1)/(bs3(1)*bs3(2));
            bs(fig_num,2)=length(bs2)/(bs3(1)*bs3(2));
            fig_num=fig_num+1;
        end
    end
    end
    
    
    if heating_time>20
        diff_tem=0;
        temp_graph=zeros(3,heating_time);
        temp_graph(1,:)=a:heating_time;
        temp_graph(2,1)=tem_med;
        check_dir=1;
        for abc=1:heating_time-1
            if (check_dir==1)
                if (temp_graph(2,abc)<target_temp+exp((-abc)/800))
                    diff_tem=((q(5,1)/density/specific_heat*1e6)+(conduc_med/density/specific_heat+0.003)*(tem_med-temp_graph(2,abc)));
                else
                    check_dir=0;
                end
            end
            if (check_dir==0)
                if (temp_graph(2,abc)>target_temp-exp((-abc)/800))
                    diff_tem=((conduc_med/density/specific_heat+0.003)*(tem_med-temp_graph(2,abc)));
                else 
                    check_dir=1;
                end
            end
            
            temp_graph(2,abc+1)=temp_graph(2,abc)+diff_tem;
            temp_graph(3,abc)=check_dir;
        end
        figure,subplot(2,1,1), plot(temp_graph(2,:))
        subplot(2,1,2), plot(temp_graph(3,:)), set(gca,'ylim',[0 2])      
    end
end
 
 
% Displays
if get(handles.peak_pressure_display,'Value')==1
    figure;
    surface(zvalues*1000,xvalues*1000,Ppeak,'Edgecolor','none');
    title('peak pressure(MPa)');
    set(gca,'xlim',[1 disp_ax]);
    xlabel('axial distance(mm)');
    ylabel('lateral distance(mm)');
    view(2);
    colorbar;
    
end
 
if get(handles.Intensity_display,'Value')==1
    figure;
    surface(zvalues*1000,xvalues*1000,inten,'Edgecolor','none');
    title('Intensity(mW/cm2)');
    set(gca,'xlim',[1 disp_ax]);
    xlabel('axial distance(mm)');
    ylabel('lateral distance(mm)');
    view(2);
    colorbar;
end
 
if get(handles.thermal_dose_display,'Value')==1
    figure;
   
end
 
if get(handles.temperature_display,'Value')==1
    figure, title('temperature')
end

