package controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.io.IOUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class DownloadfileController {

    @RequestMapping(value = "downloadfilemapping", method = RequestMethod.GET)
    public void dogetFileMapping(@RequestParam(value = "id", required = false) String _filename,
            HttpServletRequest request, HttpServletResponse response) throws Exception {
        try {

            String fileName = _filename;
            String filePathToBeServed = "D:\\DVCNT_APP\\POS_FILE_MAPPING\\";
            File fileToDownload = new File(filePathToBeServed + fileName);

            InputStream inputStream = new FileInputStream(fileToDownload);
            response.setContentType("application/force-download");
            response.setHeader("Content-Disposition", "attachment; filename=" + fileName);
            IOUtils.copy(inputStream, response.getOutputStream());
            response.flushBuffer();
            inputStream.close();
        } catch (Exception exception) {
            System.out.println(exception.getMessage());
        }
    }

    @RequestMapping(value = "downloadfile", method = RequestMethod.GET)
    public void doget(@RequestParam(value = "id", required = false) String _filename,
            HttpServletRequest request, HttpServletResponse response) throws Exception {
        try {

            String fileName = _filename;
            String filePathToBeServed = "D:\\DVCNT_APP\\POS_MOTA_DVCNT\\";
            File fileToDownload = new File(filePathToBeServed + fileName);

            InputStream inputStream = new FileInputStream(fileToDownload);
            response.setContentType("application/force-download");
            response.setHeader("Content-Disposition", "attachment; filename=" + fileName);
            IOUtils.copy(inputStream, response.getOutputStream());
            response.flushBuffer();
            inputStream.close();
        } catch (Exception exception) {
            System.out.println(exception.getMessage());
        }
    }

    @RequestMapping(value = "downloadfiletamkhoa", method = RequestMethod.GET)
    public void doget_downloadfiletamkhoa(@RequestParam(value = "id", required = false) String _filename,
            HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {

            String fileName = _filename;
            String filePathToBeServed = "D:\\DVCNT_APP\\POS_KHOA_DVCNT\\";
            File fileToDownload = new File(filePathToBeServed + fileName);

            InputStream inputStream = new FileInputStream(fileToDownload);
            response.setContentType("application/force-download");
            response.setHeader("Content-Disposition", "attachment; filename=" + fileName);
            IOUtils.copy(inputStream, response.getOutputStream());
            response.flushBuffer();
            inputStream.close();
        } catch (Exception exception) {
            System.out.println(exception.getMessage());
        }
    }

    @RequestMapping(value = "downloadfilekhoa", method = RequestMethod.GET)
    public void doget_downloadfilekhoa(@RequestParam(value = "id", required = false) String _filename,
            HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {

            String fileName = _filename;
            String filePathToBeServed = "D:\\DVCNT_APP\\POS_KHOA_DVCNT\\";
            File fileToDownload = new File(filePathToBeServed + fileName);

            InputStream inputStream = new FileInputStream(fileToDownload);
            response.setContentType("application/force-download");
            response.setHeader("Content-Disposition", "attachment; filename=" + fileName);
            IOUtils.copy(inputStream, response.getOutputStream());
            response.flushBuffer();
            inputStream.close();
        } catch (Exception exception) {
            System.out.println(exception.getMessage());
        }
    }
}
