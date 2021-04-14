package com.xxxx.manager.service;

import com.xxxx.common.result.FileResult;

import java.io.InputStream;

/**
 * @PROJECT_NAME: uoload
 * @DESCRIPTION:
 * @USER: 洋葱
 * @DATE: 2021/4/13 21:12
 */
public interface UploadService {
    /**
     *
     */
    FileResult upload(InputStream inputStream, String filename);
}
