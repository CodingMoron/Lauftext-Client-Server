import java.net.*;


/**
 * @author Luk Poncet
 * Zum senden von einfachen UDP Nachrichten
 *
 */
public class Networker {
	public String targetIP;
	public int port;
	private String errorMessage;
	private int workload;

	
	public Networker() {
	}

	
	public Networker(String targetIP, int port) {
		this.targetIP = targetIP;
		this.port = port;
	}

	
	public boolean send(String message) {

		try {
			InetAddress ip = InetAddress.getByName(this.targetIP);
			byte[] data = new byte[20];
			byte[] receiveData = new byte[8]; 
			data = message.getBytes();
			
			DatagramPacket packet = new DatagramPacket(data, data.length, ip, this.port);
			DatagramSocket socket = new DatagramSocket();
			socket.send(packet);
			
			DatagramPacket receivePacket = new DatagramPacket(receiveData, receiveData.length);
			socket.receive(receivePacket);
			socket.close();
			
			String number = new String(receivePacket.getData());
			this.workload = Integer.parseInt(number.trim());
			
			this.errorMessage = "";
			return true;
			
		} catch (Exception e) {
			this.errorMessage = e.toString();
			return false;
		}
	}

	
	public String getErrorMessage() {
		return this.errorMessage;
	}

	
	public int getWorkload() {
		return this.workload;
	}
}
