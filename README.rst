====
Aion
====
**Note:** This application is licensed under both GPLv2 and commercial license
terms.

For details on *Aion*, see our website at https://inesonic.com .

The *Aion* application project provides the program main entry point for
*Aion*.

This executable relies on the following additional libraries:

+---------------+------------------------------------------------------------+
| Library       | Provides                                                   |
+===============+============================================================+
| ineutil       | Inesonic utilities library.                                |
+---------------+------------------------------------------------------------+
| inecrypto     | Inesonic cryptographic library.                            |
+---------------+------------------------------------------------------------+
| inewh         | Inesonic webhooks library.                                 |
+---------------+------------------------------------------------------------+
| ineud         | Inesonic user data library.                                |
+---------------+------------------------------------------------------------+
| inecontainer  | Inesonic generic file container library.                   |
+---------------+------------------------------------------------------------+
| ineqcontainer | Inesonic Qt wrapper for inecontainer.                      |
+---------------+------------------------------------------------------------+
| inemat        | Inesonic matrix API library.  At this time, you must       |
|               | create your own matrix API based on the API provided by    |
|               | this library.                                              |
+---------------+------------------------------------------------------------+
| inem          | Inesonic math library.                                     |
+---------------+------------------------------------------------------------+
| inecbe        | Inesonic compiler back-end library.  Provides Qt a wrapper |
|               | for LLVM and CLANG.                                        |
+---------------+------------------------------------------------------------+
| ineld         | Inesonic Aion language definition.                         |
+---------------+------------------------------------------------------------+
| ineeqt        | Inesonic Qt extra's library.                               |
+---------------+------------------------------------------------------------+
| ineapp        | Inesonic Aion application library.                         |
+---------------+------------------------------------------------------------+

Third party dependencies include:

* The Qt libraries.
* The Boost libraries.
* LLVM and CLANG source code.

The binary version supplied by Inesonic and released under closed-source
license terms, also depends on the Intel MKL and Intel IPP libraries.
