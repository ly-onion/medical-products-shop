package com.xxxx.common.enums;

/**
 * @PROJECT_NAME: shop
 * @DESCRIPTION:
 * @USER: 洋葱
 * @DATE: 2021/5/5 12:38
 */
public enum RoleEnum {
    administrator((short) 0, "管理员"),
    merchant((short) 2, "商家"),
    buyer((short) 3, "普通用户");

    private Short code;

    private String message;

    private RoleEnum(Short code, String message) {
        this.code = code;
        this.message = message;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public static RoleEnum findMessage(Short code) {
        switch (code) {
            case 0:
                return administrator;

            case 1:
                return administrator;

            case 2:
                return merchant;

            case 3:
                return buyer;
            default:
                return buyer;
        }
    }

}
