package test;

import java.io.*;
import java.net.URL;
import java.net.URLConnection;

public class URLTest {

    public static void main(String[] args) throws Exception {
        URLConnection connection = new URL("http://iss.moex.com/iss/index.xml").openConnection();

        InputStream is = connection.getInputStream();
        InputStreamReader reader = new InputStreamReader(is);
        OutputStreamWriter writer = new OutputStreamWriter(new FileOutputStream(new File("src/main/resources/dao/Mapper.xml")));
        char[] buffer = new char[256];

        while (reader.read(buffer) != -1) {
            writer.write(buffer);
        }
        String s = "</mapper>";
        writer.write(s.toCharArray());

        reader.close();
        writer.close();
    }
}
