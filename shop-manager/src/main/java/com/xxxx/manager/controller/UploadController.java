package com.xxxx.manager.controller;

import com.xxxx.common.result.FileResult;
import com.xxxx.manager.service.UploadService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * @PROJECT_NAME: uoload
 * @DESCRIPTION:
 * @USER: 洋葱
 * @DATE: 2021/4/13 21:22
 */
@Controller
@RequestMapping("fileUpload")
public class UploadController {

    @Autowired
    private UploadService uploadService;

    @RequestMapping("save")
    @ResponseBody
    public FileResult upload(MultipartFile file) throws IOException {
        String filename = file.getOriginalFilename();
        String date =
                DateTimeFormatter.ofPattern("yyyy/MM/dd/").format(LocalDateTime.now());
        filename =
                date+System.currentTimeMillis()+filename.substring(filename.lastIndexOf("."));
        return uploadService.upload(file.getInputStream(),filename);
    }

}
