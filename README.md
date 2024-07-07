🐘 carthage
============

carthage uses the [cosmopolitan libc][cosmo] to build [αcτµαlly pδrταblε][ape] PHP executables.

We offer two flavors:

 - The embedded [PH7][PH7] engine. **~2MB ape**
 - The latest official [PHP][php]. **~30MB ape**

Please note that _BOTH BUILDS ARE EXPERIMENTAL_.

### Extensions

PH7 has no extensions, Zend PHP is built with these enabled:

 - ctype filter fileinfo ftp gmp pcntl posix session sockets tokenizer

### Building Locally

You'll need wget, unzip and make. Then:

```
sh carthage.sh
```

### Binary Releases

Releases are unavailable for now. 

You can grab leftover binaries from our [build](https://github.com/alganet/carthage/actions) artifacts if you want to test them. Click any successful build and scroll down for the archive.

[php]: http://www.php.net
[PH7]: https://ph7.symisc.net/
[ape]: https://justine.lol/ape.html
[cosmo]:https://justine.lol/cosmopolitan/
