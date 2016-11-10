/*------------------------------
 * Code based on Pixelized's Freelancer theme
 * http://www.pixelized.cz
------------------------------*/

$(window).scroll(function(){
    if($(window).scrollTop() > 600) {
        $('.navbar-default').fadeIn(300);
    }
    else {
        $('.navbar-default').fadeOut(300);
    }
    
    if($(window).width() > 767) {
        if ($(this).scrollTop() > 600) {
            $('.scroll-up').fadeIn(300);
        } else {
            $('.scroll-up').fadeOut(300);
        }       
    }
});

$(document).ready(function() {

    $("a.scroll[href^='#']").on('click', function(e) {
        e.preventDefault();
        var hash = this.hash;
        $('html, body').animate({ scrollTop: $(this.hash).offset().top}, 1000, function(){window.location.hash = hash;});
    });
    
    $('#skills-toggle').click(function() {
        $('#skills').slideToggle(500);
    });
    
    $('#overlay-hide').click(function() {
        $('#reference .reference-overlay').animate({opacity:0},1000);
        $('#reference-text').animate({opacity:0},1000);
    });
        
    $('.overlay-wrapper').mouseenter(function() {
        $(this).find('.overlay a:first-child').addClass('animated slideInLeft');
        $(this).find('.overlay a:last-child').addClass('animated slideInRight');
    });
    
    $('.overlay-wrapper').mouseleave(function() {
        $(this).find('.overlay a:first-child').removeClass('animated slideInLeft');
        $(this).find('.overlay a:last-child').removeClass('animated slideInRight');
    });
    
    $('.carousel').mouseenter(function() {
        $('.carousel-control').fadeIn(300);
    });
    
    $('.carousel').mouseleave(function() {
        $('.carousel-control').fadeOut(300);
    });
    
    if($(window).width() > 767) {
        $('.service').mouseenter(function() {
            $(this).find('img').animate({paddingBottom: '15px'},500);
        });
        
        $('.service').mouseleave(function() {
            $(this).find('img').stop().animate({paddingBottom: '0px'},500);
        });
        
        $('.scrollpoint.sp-effect1').waypoint(function(){$(this).toggleClass('active');$(this).toggleClass('animated fadeInLeft');},{offset:'90%'});
        $('.scrollpoint.sp-effect2').waypoint(function(){$(this).toggleClass('active');$(this).toggleClass('animated fadeInRight');},{offset:'90%'});
        $('.scrollpoint.sp-effect3').waypoint(function(){$(this).toggleClass('active');$(this).toggleClass('animated fadeInDown');},{offset:'90%'});
        $('.scrollpoint.sp-effect4').waypoint(function(){$(this).toggleClass('active');$(this).toggleClass('animated fadeIn');},{offset:'60%'});
        
        $('.macbook-inner').waypoint(function(){$(this).toggleClass('active');$(this).toggleClass('black');},{offset:'60%'});
    }

    $('#myNavigation ul li a').on('click', function(ev){
        if($(ev.target).parents('div').hasClass('in')){
            $('button.navbar-toggle').click();
        }
    });

    // contact form submission, clear fields, return message
    $('#contact-form').submit(function() {
        $.post(
            'php/mail.php',
            {
                name: $('#contact-input-name').val(),
                email: $('#contact-input-email').val(),
                message: $('#contact-input-message').val(),
                // recaptcha_challenge_field: $('#recaptcha_challenge_field').val(),
                // recaptcha_response_field: $('#recaptcha_response_field').val(),
                contactFormSubmitted: 'yes'
            },
            function(data) {
                $('#formResponse').html(data).fadeIn('100');
                //$('#recaptcha_response_field').val(''); /* Clear the inputs */
            },
            'text'
        );
        return false;
    });

    
});