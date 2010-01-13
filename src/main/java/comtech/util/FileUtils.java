package comtech.util;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import java.io.*;
import java.nio.ByteBuffer;
import java.nio.channels.Channels;
import java.nio.channels.ReadableByteChannel;
import java.nio.channels.WritableByteChannel;

/**
 * User: Vlad Vinichenko (akerigan@gmail.com)
 * Date: 17.04.2008
 * Time: 12:55:21
 */
public class FileUtils {

    private static Log log = LogFactory.getLog(FileUtils.class);

    public static File createTempFile(File dir, String prefix, String suffix, byte[] buffer) {
        File temp;
        try {
            // Create temp file.
            temp = File.createTempFile(prefix, suffix, dir);
            // Delete temp file when program exits.
            temp.deleteOnExit();
            // Write to temp file
            writeToFile(temp, buffer);
        } catch (IOException e) {
            log.warn("", e);
            return null;
        }
        return temp;
    }

    public static File createTempFile(String prefix, String suffix, byte[] buffer) {
        if (buffer == null) {
            return null;
        }
        File temp;
        try {
            // Create temp file.
            temp = File.createTempFile(prefix, suffix);
            // Delete temp file when program exits.
            temp.deleteOnExit();
            // Write to temp file
            writeToFile(temp, buffer);
        } catch (IOException e) {
            log.warn("", e);
            return null;
        }
        return temp;
    }

    public static void writeToFile(File file, byte[] buffer) throws IOException {
        BufferedOutputStream out = new BufferedOutputStream(new FileOutputStream(file));
        out.write(buffer);
        out.close();
    }

    public static byte[] getFileData(String fileName) throws IOException {
        if (fileName != null) {
            File file = new File(fileName);
            if (!file.exists()) {
                return null;
            } else {
                FileInputStream in = new FileInputStream(file);
                byte[] data = getStreamData(in);
                in.close();
                return data;
            }
        }
        return null;
    }

    public static byte[] getStreamData(InputStream inputStream) throws IOException {
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        copyStream(inputStream, byteArrayOutputStream);
        return byteArrayOutputStream.toByteArray();
    }

    public static void copyStream(InputStream inputStream, OutputStream outputStream) throws IOException {
        ReadableByteChannel sourceChannel = Channels.newChannel(inputStream);
        WritableByteChannel destionationChannel = Channels.newChannel(outputStream);

        // copypasted from http://thomaswabner.wordpress.com/2007/10/09/fast-stream-copy-using-javanio-channels/
        // -----
        ByteBuffer buffer = ByteBuffer.allocateDirect(16 * 1024);
        while (sourceChannel.read(buffer) != -1) {
            // prepare the buffer to be drained
            buffer.flip();
            // write to the channel, may block
            destionationChannel.write(buffer);
            // If partial transfer, shift remainder down
            // If buffer is empty, same as doing clear()
            buffer.compact();
        }
        // EOF will leave buffer in fill state
        buffer.flip();
        // make sure the buffer is fully drained.
        while (buffer.hasRemaining()) {
            destionationChannel.write(buffer);
        }
        // -----

        sourceChannel.close();
        destionationChannel.close();
    }
}