function  position_Transfer( XYcordinate,ZPostion)
%UNTITLED �� �Լ��� ��� ���� ��ġ
%   �ڼ��� ���� ��ġ
       seriallist = instrhwinfo('serial');
       port = serial(seriallist.SerialPorts{1,1});
       port.BaudRate = 19200;
       fopen(port);
       pixelSize = round(ZPostion*0.04);
       for i = 1: 1: max(size(XYcordinate))
            x_t = [ '<MVA*1#1=' num2str(XYcordinate(i,1)) ',>'];
            y_t = [ '<MVA*1#2=' num2str(XYcordinate(i,1)) ',>'];
            fprintf(port,'%s',x_t);
            fprintf(port,'%s',y_t);
       end

end

