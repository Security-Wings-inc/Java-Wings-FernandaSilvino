package rede;

import Heranca.Componentes;

public class Rede extends Componentes {
    private long bytesEnviados;
    private String ipv4;

    private String mac;


    public Rede(String nome, String descricao, long bytesEnviados) {
        super(nome, descricao);
        this.bytesEnviados = bytesEnviados;
    }

    public Rede(long bytesEnviados) {
        this.bytesEnviados = bytesEnviados;
    }

    public Rede() {

    }

    public String getBytesEnviados() {
        return String.valueOf(bytesEnviados);
    }

    public void setBytesEnviados(long bytesEnviados) {
        this.bytesEnviados = bytesEnviados;
    }

    public String getIpv4() {
        return ipv4;
    }

    public void setIpv4(String ipv4) {
        this.ipv4 = ipv4;
    }

    public String getMac() {
        return mac;
    }

    public void setMac(String mac) {
        this.mac = mac;
    }
}
