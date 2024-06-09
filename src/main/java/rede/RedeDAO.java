package rede;
import BancoDeDados.BancoLooca;
import org.example.Console;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class RedeDAO {

    public void cadastrarDados(Rede rede, Console console) {

        String sql = "UPDATE Monitoramento SET bytesEnviados = ? WHERE idMonitoramento = ?";
        String sql1 = "UPDATE Inovacao SET ipv4 = ?, mac = ? WHERE idInovacao = ?";

        try (PreparedStatement ps = BancoLooca.getbancoLooca2().prepareStatement(sql);
        PreparedStatement ps1 = BancoLooca.getbancoLooca2().prepareStatement(sql1)) {
            ps.setObject(1, rede.getBytesEnviados());
            ps.setInt(2, console.getIdMonitoramento() + 1);
            ps.executeUpdate();
            ps1.setString(1, rede.getIpv4());
            ps1.setString(2, rede.getMac() + 1);
            ps1.setDouble(3, console.getIdInovacao() + 1);

            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException( e);
        }
    }
}
