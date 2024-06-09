package rede;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import java.security.MessageDigest;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.Base64;

public class RedeCriptografia {
    public static byte[] encryptData(byte[] data, SecretKey key) throws Exception {
        Cipher cipher = Cipher.getInstance("AES");
        cipher.init(Cipher.ENCRYPT_MODE, key);
        return cipher.doFinal(data);
    }

    public static void main(String[] args) {
        try {
            // Estabelecer conexão com o banco de dados MySQL
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/securityWings", "root", "80331596");

            // Geração de uma chave de criptografia
            KeyGenerator keyGenerator = KeyGenerator.getInstance("AES");
            keyGenerator.init(256); // Tamanho da chave
            SecretKey secretKey = keyGenerator.generateKey();

            // Obter endereço IPv4 e MAC
            String ipv4Address = "192.168.4.144"; // Substitua por valor real
            String macAddress = "d0:39:57:25:13:6f"; // Substitua por valor real

            // Gerar hashes SHA-256 para IPv4 e MAC
            MessageDigest sha256 = MessageDigest.getInstance("SHA-256");
            byte[] ipv4Hash = sha256.digest(ipv4Address.getBytes());
            byte[] macHash = sha256.digest(macAddress.getBytes());

            // Criptografar os hashes SHA-256
            byte[] encryptedIpv4Hash = encryptData(ipv4Hash, secretKey);
            byte[] encryptedMacHash = encryptData(macHash, secretKey);

            // Converter os dados criptografados para strings (Base64)
            String encryptedIpv4HashString = Base64.getEncoder().encodeToString(encryptedIpv4Hash);
            String encryptedMacHashString = Base64.getEncoder().encodeToString(encryptedMacHash);

            // Preparar e executar a declaração SQL para inserir os dados criptografados no banco de dados
            String sql = "INSERT INTO Inovacao (mac, ipv4) VALUES (?, ?)";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, encryptedMacHashString);
            statement.setString(2, encryptedIpv4HashString);
            statement.executeUpdate();

            // Fechar conexão com o banco de dados
            statement.close();
            connection.close();

            System.out.println("Dados criptografados e armazenados no banco de dados com sucesso!");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
