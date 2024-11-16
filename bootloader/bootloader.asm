[BITS 16]
[ORG 0x7C00]

start:
    mov ah, 0x0E        ; Hiển thị ký tự
    mov al, 'B'         ; Hiển thị chữ 'B'
    int 0x10            ; BIOS hiển thị ký tự
    mov ah, 0x0E
    mov al, 'L'         ; Hiển thị thêm chữ 'L'
    int 0x10

    ; Nạp kernel từ sector 2 (1st sector chứa bootloader, nên kernel ở sector 2)
    mov ax, 0x1000      ; Segment load
    mov es, ax          ; ES trỏ đến segment kernel
    xor bx, bx          ; Offset = 0
    mov ah, 0x02        ; BIOS đọc sector
    mov al, 1           ; Đọc 1 sector
    mov ch, 0           ; Cylinder
    mov dh, 0           ; Head
    mov cl, 2           ; Đọc sector 2 (kernel)
    int 0x13            ; Gọi BIOS để đọc sector

    jc disk_error       ; Nếu có lỗi đọc, nhảy đến disk_error

    ; Hiển thị chữ 'K' để xác nhận kernel đã được nạp
    mov ah, 0x0E
    mov al, 'K'
    int 0x10            ; Hiển thị chữ 'K'

    ; Nhảy vào kernel đã nạp
    jmp 0x1000:0000     ; Nhảy vào địa chỉ 0x1000, nơi kernel được nạp

disk_error:
    mov ah, 0x0E
    mov al, 'E'         ; Hiển thị lỗi
    int 0x10
    hlt                 ; Dừng

times 510-($-$$) db 0   ; Đệm đủ 512 bytes
dw 0xAA55               ; Dấu hiệu bootloader

