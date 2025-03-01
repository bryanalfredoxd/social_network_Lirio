<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

require_once '../includes/config/database.php';

header('Content-Type: application/json');

// Obtener y validar el correo electrónico
$data = json_decode(file_get_contents('php://input'), true);
$email = filter_var($data['email'], FILTER_SANITIZE_EMAIL);

if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
    echo json_encode(['success' => false, 'message' => 'Correo electrónico no válido.']);
    exit;
}

// Generar un código de verificación de 6 dígitos
$codigo = rand(100000, 999999);
$fecha_expiracion = date('Y-m-d H:i:s', strtotime('+1 hour'));

try {
    // Verificar si el correo existe en la base de datos
    $stmt = $conn->prepare("SELECT id FROM usuarios WHERE email = ?");
    $stmt->bind_param("s", $email);
    $stmt->execute();
    $result = $stmt->get_result();
    $usuario = $result->fetch_assoc();

    if (!$usuario) {
        echo json_encode(['success' => false, 'message' => 'Correo no encontrado.']);
        exit;
    }

    // Guardar el código en la base de datos usando mysqli
    $stmt = $conn->prepare("UPDATE usuarios SET codigo_recuperacion = ?, fecha_expiracion_codigo = ? WHERE email = ?");
    $stmt->bind_param("sss", $codigo, $fecha_expiracion, $email);
    $stmt->execute();

    if ($stmt->affected_rows > 0) {
        // Configurar el correo electrónico
        $subject = "Código de Verificación - UneRed";
        $message = "
            <h1>Código de Verificación</h1>
            <p>Tu código de verificación para restablecer tu contraseña es:</p>
            <h2>$codigo</h2>
            <p>Este código expirará en 1 hora.</p>
            <p>Si no fuiste tú quien solicitó este código, te recomendamos cambiar tu contraseña de inmediato para proteger tu cuenta.</p>
            <p>Atentamente,</p>
            <p>Equipo de Soporte UneRed</p>
        ";

        // Cabeceras del correo
        $headers = "MIME-Version: 1.0" . "\r\n";
        $headers .= "Content-type:text/html;charset=UTF-8" . "\r\n";
        $headers .= "From: UneRed <uneredsupport@gmail.com>" . "\r\n";
        $headers .= "Reply-To: no-reply@uneredsupport.com" . "\r\n";
        $headers .= "X-Mailer: PHP/" . phpversion();

        // Enviar el correo usando sendmail
        if (mail($email, $subject, $message, $headers)) {
            echo json_encode(['success' => true, 'message' => 'Código enviado correctamente.']);
        } else {
            echo json_encode(['success' => false, 'message' => 'Error al enviar el correo.']);
        }
    } else {
        echo json_encode(['success' => false, 'message' => 'Error al actualizar la base de datos.']);
    }
} catch (Exception $e) {
    echo json_encode(['success' => false, 'message' => 'Error en el servidor: ' . $e->getMessage()]);
}
?>
